class Api::BaseController < ActionController::Base
  acts_as_token_authentication_handler_for User, fallback_to_devise: false
  respond_to :json

  private

  def current_user
    @current_user
  end
end