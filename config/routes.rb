Rails.application.routes.draw do
  devise_for :users, {registration: "api/registration", sessions: "api/sessions"}
  namespace :api do
    resources :registrations, only: [:create]
    resources :sessions, only: [:create, :destroy]
    resources :aquariums do
      resource :readings, only: [:index, :create, :show, :new]
    end
  end

  mount MailPreview => 'mail_view' if Rails.env.development?
  root to: 'static#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

end
