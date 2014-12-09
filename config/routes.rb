Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    resource :sessions
    resource :registrations
    resource :reading, as: 'sensor_reading'
    with_options except: [:create, :update, :destroy] do |read_only|
      read_only.resources :reading
    end
  end

  mount MailPreview => 'mail_view' if Rails.env.development?
  root to: 'static#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

end
