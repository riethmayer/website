ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.resource :session

    admin.resource :dashboard, :controller => 'dashboard'

    admin.resources :posts, :new => {:preview => :post}
    admin.resources :pages, :new => {:preview => :post}
    admin.resources :tags
    admin.resources :undo_items, :member => {:undo => :post}
  end

  map.admin_health '/admin/health/:action', :controller => 'admin/health', :action => 'index'

  map.connect '/admin', :controller => 'admin/dashboard', :action => 'show'
  map.connect '/admin/api', :controller => 'admin/api', :action => 'index'
  map.archives '/archives', :controller => 'archives', :action => 'index'

  map.root :controller => 'pages', :action => 'show', :id => 'welcome'
  map.resources :posts

  map.resources :pages

  map.connect ':year/:month/:day/:slug', :controller => 'posts', :action => 'show', :requirements => { :year => /\d+/ }
  map.posts_with_tag ':tag', :controller => 'posts', :action => 'index'
  map.formatted_posts_with_tag ':tag.:format', :controller => 'posts', :action => 'index'
end
