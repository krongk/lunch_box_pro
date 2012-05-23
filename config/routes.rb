RailsOnWeb::Application.routes.draw do

  resources :project_items

  resources :project_cates

  resources :contacts

  resources :comments

  resources :shops

  resources :resource_items

  resources :resource_cates

  resources :product_items

  resources :product_cates

  resources :news_items

  resources :news_cates

  #resources :page_parts
  #resources :parts
  #resources :sites
  resources :pages

  get "home/index"
  match "about" => "pages#show", :id => 'about'
  match "sitemap" => "pages#show", :id => 'sitemap'
  match "contact" => "contacts#new"
  
  match "form" => "home#form"
  match "search" => "home#search"

  match "upload" => "resource_items#upload"
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users


  # match "/a/:model/:state" => "sanctions#index", :constraints => {:model => /(doctor|dentist)/, :state => /(wa|oh)/}
  # scope "/:model/:state/:cate(/:history)", :constraints => {:history => /history/i, :cate => /(date|title)/i, :model => /(doctor|dentist|podiatrist)/i, :state => /(#{StateList::STATE_ABBR.join('|')})/i } do
  #   resources :sanctions
  # end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
