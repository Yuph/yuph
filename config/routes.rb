Yuph::Application.routes.draw do

  constraints CanAccessRailsAdmin do
    mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  end

  # Root action => '/'
  root 'session#index'

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
  # forum doesnt need to have routes for now, maybe nest it on the ideas
  # resources :forum
  resources :categories
  resources :posts
  resources :post_comments

  # Devise routes
  devise_for :users, controllers: {registrations: 'registrations', omniauth_callbacks: 'users/omniauth_callbacks'}
  devise_scope :user do
    get "login", :to => "devise/sessions#new"
    get "logout", :to => "devise/sessions#destroy"
    get "register", :to => "registrations#new"
  end

  resources :users, :except => [:new, :create]
  get 'users/:id/api' => 'users#api', :as => 'user_api'

  resources :notifications, :only => [:index, :show]
end
