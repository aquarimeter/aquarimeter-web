class Api::V1::SessionsController < Devise::SessionsController
  after_filter :reset_authentication_token, :only => [:create]
  before_filter :reset_authentication_token, :only => [:destroy]

  def reset_authentication_token
    current_user.reset_authentication_token!
  end

  def create
    warden.authenticate!(:scope => resource_name)
    @user = current_user
    render json: @user, status: :ok, message:"logged in "
  end


  def destroy
    resource.reset_authentication_token!
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    render :status => 200, :json => {message: "logged out successfully!"}
  end

  def reset_authentication_token
    current_user.reset_authentication_token!
  end
end
