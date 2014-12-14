module Api
  module V1
    class SessionsController < Devise::SessionsController
      respond_to :json
      skip_before_filter :verify_authenticity_token, if: :json_request?

      acts_as_token_authentication_handler_for User, fallback_to_devise: false
      skip_before_filter :authenticate_entity_from_token!
      skip_before_filter :authenticate_entity!
      before_filter :authenticate_entity_from_token!, :only => [:destroy]
      before_filter :authenticate_entity!, :only => [:destroy]

      def create
        warden.authenticate!(:scope => resource_name)
        @user = current_user

        render json: {
                  message: 'Logged in',
                  auth_token: @user.authentication_token
              }, status: :ok
      end

      def destroy
        if user_signed_in?
          @user = current_user
          @user.authentication_token = nil
          @user.save

          respond_to do |format|
            format.json {
              render json: {
                    message: 'Logged out successfully.'
                }, status: :ok
            }
          end
        else
          respond_to do |format|
            format.json {
              render json: {
                    message: 'Failed to log out. User must be logged in.'
                }, status: :unauthorized
            }
          end
        end
      end

      private

      def json_request?
        request.format.json?
      end
    end
  end
end