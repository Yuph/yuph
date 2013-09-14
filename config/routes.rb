Yuph::Application.routes.draw do

  # Root action => '/'
  root 'session#index'

  # Users controller
  resources :users

  # Ideas Controller
  resources :ideas

  # Follows Controller
  resources :follows, only: [:create, :destroy]

  # Messages Controller
  resources :messages

  # User comments controller
  resources :user_comments, only:[:create, :destroy]

  # Idea Comments controller
  resources :idea_comments, only:[:create, :destroy]

  # Idea Admins controller
  resources :idea_admins

  # Forum Routes
  resources :forum
  resources :categories
  resources :posts
  resources :post_comments

  # Session Routes
  get 'login' => 'session#index'
  post 'login' => 'session#login'
  get 'logout' => 'session#logout'
end
