class Api::BaseController < ApplicationController
  # define which model will act as token authenticatable
  acts_as_token_authentication_handler_for User

  respond_to :json
  skip_before_filter :verify_authenticity_token, if: :json_request?

  private

  def json_request?
    request.format.json?
  end
end