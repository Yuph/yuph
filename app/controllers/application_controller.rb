class ApplicationController < ActionController::Base
  helper :application
  protect_from_forgery with: :exception

  before_filter :authenticate_user!

  def set_session_user
    @user = current_user
  end
end
