class ApplicationController < ActionController::Base
  #these includes are needed because ActionController::API doesn't include things devise needs
  include ActionController::MimeResponds
  include ActionController::ImplicitRender
  include SimpleTokenAuthentication::ActsAsTokenAuthenticationHandler

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) do |u|
      u.permit(:email, :password)
    end
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation, :first_name, :last_name)
    end
  end

  def set_user
    @user = current_user
  end

end