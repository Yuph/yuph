Yuph::Application.routes.draw do

  root 'welcome#index'

  resources :users
  resources :ideas

  # Session Routes
  get 'login' => 'session#index'
  post 'login' => 'session#login'
  get 'logout' => 'session#logout'
end
