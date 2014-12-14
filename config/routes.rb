Rails.application.routes.draw do
  devise_for :users, :path_prefix => 'api/v1', :skip => [:sessions, :registrations, :passwords]

  namespace :api do
    namespace :v1, :format => :json do
      devise_scope :user do
        post 'login' => 'sessions#create', :as => :login, defaults: { format: 'json' }
        delete 'logout' => 'sessions#destroy', :as => :logout, defaults: { format: 'json' }
      end
      resources :aquariums,defaults: { format: 'json' } do
        resource :readings, only: [:index, :create, :show, :new], defaults: { format: 'json' }
      end

    end
    mount MailPreview => 'mail_view' if Rails.env.development?
    root to: 'static#index'
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  end


end