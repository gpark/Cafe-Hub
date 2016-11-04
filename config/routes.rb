Rails.application.routes.draw do
  devise_for :users
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  
  root to: "dashboard#home"
  post '/preferences' => 'dashboard#create_preference'
  post '/preference' => 'dashboard#create_preference'
  get '/dashboard/preferences' => 'dashboard#show_preferences'
  get '/dashboard/new_preference' => 'dashboard#new_preference'
  get '/dashboard' => 'dashboard#home'
  patch '/preference' => 'dashboard#create_preference'
  get 'users/all' => 'users#all'
  get '/users/:id' => 'users#assignments'
  get 'users/:id/assignments' => 'users#assignments'
  get 'users/:id/preference' => 'users#preference'
  
  resource :assignments
  resource :facilities
  resource :assignments_weeks
  
  get '/settings' => 'settings#index'
  patch '/settings' => 'settings#update'
  
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

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
