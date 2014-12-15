Rails.application.routes.draw do
  devise_for :users, :path_prefix => 'api/v1', :ip => [:sessions, :registrations, :password,:confirmation, :unlock]

  namespace :api do
    namespace :v1, :format => :json do
      devise_scope :user do
        post 'login' => 'sessions#create', :as => :login, defaults: { format: 'json' }
        delete 'logout' => 'sessions#destroy', :as => :logout, defaults: { format: 'json' }
        post 'register' => 'registrations#create', :as => :register
        delete 'delete_account' => 'registrations#destroy', :as => :delete_account
      end
      resources :aquariums,param: :name,defaults: { format: 'json' } do
        resource :readings, only: [:index, :create, :show, :new], defaults: { format: 'json' }
      end
    end
  end
  mount MailPreview => 'mail_view' if Rails.env.development?
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :only => [:password,:confirmation,:unlock]

end