class Api::V1::BaseController < ApplicationController
  respond_to :json

  private
  def authenticate_user
    @current_user = User.find_by_authentication_token(params[:auth_token])
    # Adding the conditional to throw json error
    unless @current_user
      render json: {error: 'Token is invalid', status: 403}
    end
  end

  def json_request?
    request.format.json?
  end
end