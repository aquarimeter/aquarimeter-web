class Api::V1::BaseController < ApplicationController
  respond_to :json

  private
  #filter to check auth token
  def authenticate_user
    if not params.has_key?(:auth_token)
      failure
      return
    end
    @current_user = User.find_by_authentication_token(params[:auth_token])
    # Adding the conditional to throw json error
    unless @current_user
      failure
    end
  end

  def json_request?
    request.format.json?
  end
  ## Keep it DRY :D
  def failure
    render json: {error: 'Token is invalid.'},:status => :unauthorized
  end
end