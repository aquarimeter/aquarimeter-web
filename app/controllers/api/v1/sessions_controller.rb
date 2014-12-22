# taken from http://lucatironi.github.io/tutorial/2012/10/15/ruby_rails_android_app_authentication_devise_tutorial_part_one/
class Api::V1::SessionsController < Devise::SessionsController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }
  skip_before_filter :verify_signed_out_user

  respond_to :json

  def create
    resource = User.find_for_database_authentication(:email => params[:user][:email])
    return failure unless resource

    if resource.valid_password?(params[:user][:password])
      sign_in(:user, resource)
      resource.ensure_authentication_token!
      render :json => {:user => resource, :auth_token => resource.authentication_token}, :status => :ok
    else
      failure
    end
  end

  def destroy
    warden.authenticate!(:scope => resource_name, :recall => :failure)
    current_user.update_column(:authentication_token, nil)
    current_user = nil
    render :status => :ok,
           :json => {:success => true,
                     :info => "Logged out",
                     :data => {}}
  end

  def failure
    render :status => :unauthorized,
           :json => {:success => false,
                     :info => "Login Failed"}
  end
end