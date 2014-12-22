Rails.application.routes.draw do

  namespace :api do
    namespace :v1, :format => :json do
      devise_scope :user do
        post 'login' => 'sessions#create', :as => :login, defaults: { format: 'json' }
        delete 'logout' => 'sessions#destroy', :as => :logout, defaults: { format: 'json' }
        post 'register' => 'registrations#create', :as => :register
        patch 'update_user' => 'registrations#updates', :as => :update_info
        delete 'delete_account' => 'registrations#destroy', :as => :delete_account
      end
      resources :aquariums,param: :name,defaults: { format: 'json' } do
        resource :readings
        resources :images
      end
    end
  end
  devise_for :user
  resources :aquariums, only: [:show, :update, :destroy],param: :name

  mount MailPreview => 'mail_view' if Rails.env.development?
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'aquariums#index'

end