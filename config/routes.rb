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
  resources :forum
  resources :categories
  resources :posts
  resources :post_comments

  # Devise routes
  devise_for :users, controllers: {registrations: 'registrations'}
  devise_scope :user do
    get "login", :to => "devise/sessions#new"
    get "logout", :to => "devise/sessions#destroy"
    get "register", :to => "registrations#new"
  end

  resources :users, :except => [:new, :create]

  # Facebook Login
  get "/auth/:provider/callback" => "session#facebook_login_successfuly", as: :auth_callback
  get "/auth/failure" => "session#facebook_login_failure", as: :auth_failure
end
