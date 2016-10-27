Rails.application.routes.draw do




  resources :closures

  resources :sessions
  get 'welcome/index'

  get 'login' => 'sessions#new', as: :login
  get 'logout' => 'sessions#destroy', as: :logout

  get 'check_pdf' => 'welcome#check_pending_pdf'
  get 'download' => 'welcome#download'
  


  post 'create_admin_user' => 'welcome#create_admin_user', as: :create_admin_user
  get 'admin_user' => 'welcome#admin_user', as: :administrator_user
  


# post 'deposits/:deposit_id/products' => 'deposits_products#create'
#  get 'deposits/:deposit_id/new' => 'deposits_products#new', as: :new_deposits_product
#  get 'deposits/:deposit_id/products/:id/edit' => 'deposits_products#edit', as: :edit_deposits_product
 # get 'deposits/:deposit_id/products/:id' => 'deposits_products#show', as: :deposits_product
  


  get 'admin' => 'welcome#admin', as: :admin_index
  get 'owner' => 'welcome#owner', as: :owner_index
  get 'seller' => 'welcome#seller', as: :seller_index

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  get 'my_profile' => 'users#my_profile', as: :my_profile
  namespace "admin" do
    resources :users
    resources :roles
    resources :commerces
    resources :stores
    resources :deposits
    resources :sellers
    resources :downloads
    resources :loads
  end
  
 
  namespace "owner" do
    resources :users
    resources :commerces do
      resources :deposits, :stores,:sellers
      get 'deposits/:id/products' => 'deposits#products', as: :deposit_products
      get 'deposits/:id/products/new' => 'deposits#new_product', as: :new_deposit_product
      get 'deposits/:deposit_id/products/:product_id' => 'deposits#show_product', as: :deposit_product
      post 'deposits/:deposit_id/products' => 'deposits#add_product'
      get 'deposits/:deposit_id/products/:product_id/edit' => 'deposits#edit_product', as: :edit_deposit_product
      patch 'deposits/:deposit_id/products/:product_id' => 'deposits#update_product' 
      put 'deposits/:deposit_id/products/:product_id' => 'deposits#update_product' 
      
      get 'stores/:store_id/products' => 'stores#products', as: :store_products
      get 'stores/:store_id/products/new' => 'stores#new_product', as: :new_store_product
      get 'stores/:store_id/products/:product_id' => 'stores#show_product', as: :store_product 
      post 'stores/:store_id/products' => 'stores#add_product'
      get 'stores/:store_id/products/:id/edit' => 'stores#edit_product', as: :edit_store_product
      patch 'stores/:store_id/products/:id' => 'stores#update_product' 
      put 'stores/:store_id/products/:id' => 'stores#update_product' 
      get 'stores/:store_id/close_cash' => 'stores#close_cash', as: :close_cash
      
    end
    resources :loads
    resources :downloads
    resources :sales
    resources :bills
  end
  
  namespace "seller" do
    resources :users
    get 'store/products' => 'stores#products', as: :store_products
    get 'store' => 'stores#show', as: :store
    get 'store/close_cash' => 'stores#close_cash', as: :close_cash
      
    resources :sales
    resources :bills

  end
    resources :users
    resources :products
    resources :categories
    resources :brands
    resources :units
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
