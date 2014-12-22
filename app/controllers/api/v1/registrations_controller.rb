class Api::V1::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user!

  respond_to :json

  def create
    build_resource(sign_up_params)
    if resource.save
      respond_with resource, status: :created
    else
      clean_up_passwords resource
      status = :internal_server_error
      message = "Failed to create new account, please correct any errors."
      render :status => :unprocessable_entity, json: {errors: @user.errors, message: message}
    end
  end

  def destroy
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    render json: {message: 'Successfully deleted the account.'
              }, status: :ok
  end

  private

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end

  def json_request?
    request.format.json?
  end
end