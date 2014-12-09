class Api::BaseController < ApplicationController
  include Devise::Controllers::Helpers
  respond_to :json
  protect_from_forgery with: :null_session
  skip_before_filter  :verify_authenticity_token


end
