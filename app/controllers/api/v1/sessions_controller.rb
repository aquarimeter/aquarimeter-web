# Taken from github.com/bdwain/simple_authentication_token_sample_app
module Api
  module V1
    class SessionsController < Devise::SessionsController
      respond_to :json
      skip_before_filter :verify_authenticity_token, if: :json_request?

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
        resource.reset_authentication_token!
        Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
        render :status => 200, :json => {}
      end
    end
  end
end