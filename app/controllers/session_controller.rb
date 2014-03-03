class SessionController < ApplicationController
  skip_before_filter :authenticate_user!, :all

  def index
    @yuph = Idea.first
    @ideas = Idea.last(4)
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
end
