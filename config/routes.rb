ActionController::Routing::Routes.draw do |map|
  map.resources :cleaning_items

  map.resources :searches
  
  
  map.resources :posts
  
  
  map.resources :recipients
  
  map.resources :all_users
  
  # Home route leads to inbox
  map.inbox 'inbox', :controller => "mailbox", :action => "index"
  map.trash 'trash', :controller => "mailbox", :action => "trash"
  
  
  map.resources :users, :sent
  #map.resources :mailbox, :collection => { :trash => :get }
  map.resources :messages, :member => { :reply => :get, :forward => :get, :reply_all => :get, :undelete => :put }
  
  map.login "login", :controller => "user_sessions", :action => "new"
  map.mail_login "mail_login", :controller => "user_sessions", :action => "validate_for_mail"
  map.is_mail_login "is_mail_login", :controller => "user_sessions", :action => "is_valid_for_mail"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"
  
  map.resources :user_sessions
  
  map.search '/search', :controller => 'search', :action => 'search_index'
  
  map.resources :pages
  
  map.root :controller => "posts"
  
  
  
  
  
  # The priority is based upon order of creation: first created -> highest priority.
  
  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action
  
  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)
  
  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products
  
  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }
  
  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end
  
  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end
  
  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"
  
  # See how all your routes lay out with "rake routes"
  
  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
  
end
