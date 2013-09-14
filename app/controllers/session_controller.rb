class SessionController < ApplicationController
  skip_before_filter :authenticate, :all

  def index
    @yuph = Idea.find(1)
    @ideas = Idea.last_four
  end

  def login
    user = User.login(params[:user][:email], params[:user][:password])
    if !user.blank?
      session[:user] = user.id
      redirect_to user
    else
      flash[:notice] = "Credentials failure"
      redirect_to action: :index
    end
  end

  def facebook_login_successfuly
    auth = request.env["omniauth.auth"]
    user = User.find_or_create_with_omniauth(auth)
    puts user.email
    session[:user] = user.id
    redirect_to user_path(user)
  end

  def facebook_login_failure
    redirect_to :back
  end

  def logout
    session[:user] = nil
    redirect_to action: :index
  end
end
