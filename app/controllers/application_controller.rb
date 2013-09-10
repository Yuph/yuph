class ApplicationController < ActionController::Base
  helper :application
  protect_from_forgery with: :exception
  before_filter :authenticate

  def authenticate
		redirect_to :controller => "session", :action => "index" if session[:user] == nil
	end
  def set_session_user
  	@user = User.find(session[:user])
  end
end
