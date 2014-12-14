# Taken from github.com/bdwain/simple_authentication_token_sample_app
class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  skip_before_filter :verify_authenticity_token, if: :json_request?

  skip_before_filter :authenticate_entity_from_token!, only: [:create]
  skip_before_filter :authenticate_entity!, only: [:create]

  skip_before_filter :authenticate_scope!
  append_before_filter :authenticate_scope!, only: [:destroy]
  before_filter :validate_auth_token, :except => :create

  def create
    build_resource(sign_up_params)
    if resource.save
      status = :ok
      message = "Successfully created new account for email #{sign_up_params[:email]}."
      render json: {message: message, status: status, user: @user}
      clean_up_passwords resources
      status = :internal_server_error
      message = "Failed to create new account for email #{sign_up_params[:email]}."
      render json: {message: message, status: status, params: params}
    end
    Rails.logger = Logger.new(STDOUT)
    logger.debug "FOOOOOO #{message}, #{status}"
  end

  def destroy
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)


    render json: {
                  message: 'Successfully deleted the account.'
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
