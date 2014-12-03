class CreateAdminService
  def call
    user = User.find_or_create_by!(email: Rails.application.secrets.admin_email) do |user|
        user.first_name = Rails.application.secrets.admin_first_name
        user.last_name = Rails.application.secrets.admin_last_name
        user.password = Rails.application.secrets.admin_password
        user.password_confirmation = Rails.application.secrets.admin_password
        user.confirm!
        user.admin!
      end
  end
end
