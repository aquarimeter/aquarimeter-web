class Api::SessionsController < Api::BaseController
  before_filter :authenticate_user!, except: [:create]
  before_filter :ensure_email_param_exists, only: [:create]
  before_filter :ensure_password_param_exists, only: [:create]
  respond_to :json

  def create
    resource = User.find_for_database_authentication(email: params[:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:password])
      sign_in(:user, resource)
      resource.ensure_authentication_token!
      render json: { success: true, auth_token: resource.authentication_token, email: resource.email }, status: :created
      return
    end
    invalid_login_attempt
  end

  def destroy
    current_user.reset_authentication_token
    render json: { success: true }, status: :ok
  end

  protected

  def ensure_email_param_exists
    ensure_param_exists :email
  end

  def ensure_password_param_exists
    ensure_param_exists :password
  end

  def ensure_param_exists(param)
    return unless params[param].blank?
    render json:{ success: false, message: "Missing #{param} parameter"}, status: :unprocessable_entity
  end

  def invalid_login_attempt
    render json: { success: false, message: "Error with your login or password"}, status: :unauthorized
  end
end