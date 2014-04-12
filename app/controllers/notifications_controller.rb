class NotificationsController < ApplicationController

  after_filter :only => [:index] do
    current_user.update_attribute :latest_activity_id, @activities.first.try(:id)
  end

  def index
    @display_activities = @activities.page(params[:page]).per(10)
    @latest = current_user.latest_activity
  end

end