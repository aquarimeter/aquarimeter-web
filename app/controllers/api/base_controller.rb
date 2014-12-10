class Api::BaseController < ActionController::Base
  before_filter :authenticate_user

  respond_to :json

  private
  private
  def authenticate_user
    @current_user = User.find_by_authentication_token(params[:token])
    unless @current_user
      respond_with json: ({:error => "Token is invalid." })
    end
  end

  def current_user
    @current_user
  end
end