Borker::Application.routes.draw do

  root 'borks#index'

  namespace :api do
    resources :users, only: [:index]
    post 'authenticate' => 'users#authenticate'
    post 'add_token' => 'users#add_token'
    get 'user_borks' => 'users#user_borks'
    get 'user_id' => 'users#user_id'
    get 'favorites' => 'users#favorites'
    resources :borks, only: [:index, :create]
    delete 'borks' => 'borks#destroy'
    post 'undo_delete' => 'borks#undo_delete'
    resources :notifications, only: [:index]
    post 'favorites' => 'favorites#create'
    delete 'favorites' => 'favorites#destroy'
    get 'favorited' => 'favorites#favorited'
    get 'bork_favorites' => 'borks#bork_favorites'
  end

  get 'sessions/new', as: 'login'
  get 'sessions/create'
  get 'sessions/destroy', as: 'logout'

  get 'signup' => 'users#new', as: 'signup'
  get 'users/:id/favorites' => 'users#favorites', as: 'favorites'
  get 'borks/:id/favorite' => 'favorites#create', as: 'favorite'
  get 'borks/:id/unfavorite' => 'favorites#destroy', as: 'unfavorite'

  get 'jamesify' => 'borks#jamesify', as: 'jamesify_bork'
  get 'borks_for_app.json' => 'borks#borks_for_app'
  get 'random' => 'borks#random'

  resources :sessions
  resources :users
  resources :borks
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
