Nottwitter::Application.routes.draw do


  root 'nottweets#index'

  namespace :api do
    resources :users, only: [:index, :authenticate]
    resources :nottweets, only: [:index, :create]
    resources :notifications, only: [:index]
  end

  get 'sessions/new', as: 'login'
  get 'sessions/create'
  get 'sessions/destroy', as: 'logout'

  get 'signup' => 'users#new', as: 'signup'
  post 'authenticate' => 'users#authenticate'

  get 'users/:id/favorites' => 'users#favorites', as: 'favorites'
  get 'nottweets/:id/favorite' => 'favorites#create', as: 'favorite'
  get 'nottweets/:id/unfavorite' => 'favorites#destroy', as: 'unfavorite'

  get 'jamesify' => 'nottweets#jamesify', as: 'jamesify_bork'
  get 'borks_for_app.json' => 'nottweets#borks_for_app'

  resources :sessions
  resources :users
  resources :nottweets
  resources :notifications

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
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
