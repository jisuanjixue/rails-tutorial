Rails.application.routes.draw do
   root 'home#index'
   # 用户资源使用特殊的 resources 方法自动获得符合 REST 架构的路由
  resources :users
  get  '/signup',  to: 'users#new'
  # 创建新会话的页面（登录）, HTTP请求GET, URL: /login, 具名路由: login_path, 动作:new
  get '/login', to: 'sessions#new'

  #创建新会话（登录）,HTTP请求POST, URL: /login, 具名路由: login_path, 动作:create
  post '/login', to: 'sessions#create'
  
  # 删除会话（退出）, HTTP请求DELETE, URL: /logout, 具名路由: logout_path, 动作:destroy
  delete '/logout', to: 'sessions#destroy'
end
