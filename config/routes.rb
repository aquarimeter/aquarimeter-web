Rails.application.routes.draw do
  root 'static#index'
  get 'static/index'
  devise_for :users
  mount MailPreview => 'mail_view' if Rails.env.development?
end
