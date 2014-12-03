Rails.application.routes.draw do
  root to: 'static#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :users
mount MailPreview => 'mail_view' if Rails.env.development?end
