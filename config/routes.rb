Rails.application.routes.draw do
  get 'images/create'

  get 'images/update'

  get 'images/show'

  get 'images/destroy'

devise_for :user

  namespace :api do
    namespace :v1, :format => :json do
      devise_for :user, {registration: "api/registration", sessions: "api/sessions"}
      devise_scope :user do
        post 'login' => 'sessions#create', :as => :login, defaults: { format: 'json' }
        delete 'logout' => 'sessions#destroy', :as => :logout, defaults: { format: 'json' }
        post 'register' => 'registrations#create', :as => :register
        patch 'update_user' => 'registrations#updates', :as => :update_info
        delete 'delete_account' => 'registrations#destroy', :as => :delete_account
      end
      resources :aquariums,param: :name,defaults: { format: 'json' } do
        resource :readings
        resource :images, controller: "api/v1/images"
      end
    end
  end
  get "about" => "static#about"


  resources :aquariums,param: :name do
    resource :images, controller: "images"
  end
  require 'sidekiq/web'

  mount Sidekiq::Web => '/sidekiq'
  mount MailPreview => 'mail_view' if Rails.env.development?
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'aquariums#index'

end
