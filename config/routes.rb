Rails.application.routes.draw do
  mount Upmin::Engine => '/admin'
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     mount MailPreview => 'mail_view' if Rails.env.development?end
  #
  #     collection do
  #       get 'sold'
  #     mount MailPreview => 'mail_view' if Rails.env.development?end
  #   mount MailPreview => 'mail_view' if Rails.env.development?end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   mount MailPreview => 'mail_view' if Rails.env.development?end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     mount MailPreview => 'mail_view' if Rails.env.development?end
  #   mount MailPreview => 'mail_view' if Rails.env.development?end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   mount MailPreview => 'mail_view' if Rails.env.development?end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   mount MailPreview => 'mail_view' if Rails.env.development?end
mount MailPreview => 'mail_view' if Rails.env.development?end
