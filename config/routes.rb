Yuph::Application.routes.draw do

  root 'welcome#index'

  resources :users
  resources :ideas
  resources :forum
  resources :follows
  resources :messages
  resources :categories
  resources :posts
  resources :user_comments
  resources :idea_comments
  resources :idea_admins

  # Session Routes
  get 'login' => 'session#index'
  post 'login' => 'session#login'
  get 'logout' => 'session#logout'
end
