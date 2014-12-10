#http://jessewolgamott.com/blog/2012/01/19/the-one-with-a-json-api-login-using-devise/
class Api::RegistrationsController < Api::BaseController
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user.as_json, status: :created
    else
      render json: @user.errors.as_json, status: :unprocessable_entity
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name)
  end
end