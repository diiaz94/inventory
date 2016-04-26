Rails.application.routes.draw do
  resources :roles

  resources :downloads

  resources :loads

  resources :stores

  resources :brands

  resources :units

  get 'welcome/index'

  #resources :deposits_products

  resources :products

  resources :deposits

  resources :categories

  resources :commerces

  resources :profiles
  resources :sessions

  get 'login' => 'sessions#new', as: :login
  get 'logout' => 'sessions#destroy', as: :logout

  get 'deposits/:deposit_id/products' => 'loads#products_of_deposit', as: :products_of_deposit
  get 'deposits/:deposit_id/products/new' => 'loads#new_product_of_deposit', as: :new_product_of_deposit
  get 'deposits/:deposit_id/products/:id' => 'loads#show', as: :product_of_deposit 
  post 'deposits/:deposit_id/products' => 'loads#create_product_of_deposit'
  get 'deposits/:deposit_id/products/:id/edit' => 'loads#edit_product_of_deposit', as: :edit_product_of_deposit
  patch 'deposits/:deposit_id/products/:id' => 'loads#update_product_of_deposit' 
  put 'deposits/:deposit_id/products/:id' => 'loads#update_product_of_deposit' 

  get 'stores/:store_id/products' => 'downloads#products_of_store', as: :products_of_store
  get 'stores/:store_id/products/new' => 'downloads#new_product_of_store', as: :new_product_of_store
  get 'stores/:store_id/products/:id' => 'downloads#show', as: :product_of_store 
  post 'stores/:store_id/products' => 'downloads#create_product_of_store'
  get 'stores/:store_id/products/:id/edit' => 'downloads#edit_product_of_store', as: :edit_product_of_store
  patch 'stores/:store_id/products/:id' => 'downloads#update_product_of_store' 
  put 'stores/:store_id/products/:id' => 'downloads#update_product_of_store' 
  


  post 'create_admin_user' => 'welcome#create_admin_user', as: :create_admin_user
  get 'admin_user' => 'welcome#admin_user', as: :admin_user
  

# post 'deposits/:deposit_id/products' => 'deposits_products#create'
#  get 'deposits/:deposit_id/new' => 'deposits_products#new', as: :new_deposits_product
#  get 'deposits/:deposit_id/products/:id/edit' => 'deposits_products#edit', as: :edit_deposits_product
 # get 'deposits/:deposit_id/products/:id' => 'deposits_products#show', as: :deposits_product
  resources :users

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

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
