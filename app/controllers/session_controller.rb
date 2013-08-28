class SessionController < ApplicationController
  skip_before_filter :authenticate, only: [:index, :login]
  def index
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
  def logout
    session[:user] = nil
  end
end
