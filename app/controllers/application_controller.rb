class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  helper :application
  protect_from_forgery with: :exception

  before_filter :authenticate_user!
  before_filter :load_recent_activities, if: :current_user

  def load_recent_activities
    @activities = current_user.latest_activities
    @new_activities = current_user.latest_activities.where('created_at > ?', current_user.latest_activity.try(:created_at))
  end

  def set_session_user
    @user = current_user
  end
end
