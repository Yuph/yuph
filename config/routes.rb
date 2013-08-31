Yuph::Application.routes.draw do

  root 'welcome#index'

  resources :users
  resources :ideas
  resources :forum
  resources :messages
  resources :user_comments
  resources :idea_comments

  # Session Routes
  get 'login' => 'session#index'
  post 'login' => 'session#login'
  get 'logout' => 'session#logout'
end
