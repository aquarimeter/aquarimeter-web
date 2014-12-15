class Api::V1::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user!

  respond_to :json

  def create
    build_resource(sign_up_params)
    if resource.save
      status = :ok
      message = "Successfully created new account for email #{sign_up_params[:email]}."
      render json: {message: message, auth_token: @user.authentication_token}, status => :created
    else
      clean_up_passwords resource
      status = :internal_server_error
      message = "Failed to create new account for email #{sign_up_params[:email]}."
      render json: {errors: @user.errors, message: message}, status => :unprocessable_entity
    end
  end

  def destroy
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)

    respond_to do |format|
      format.json {
        render json: {
                 message: 'Successfully deleted the account.'
             }, status: :ok
      }
    end
  end

  private

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end

  def json_request?
    request.format.json?
  end
end
