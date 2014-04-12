class NotificationsController < ApplicationController

  after_filter :only => [:index] do
    current_user.update_attribute :latest_activity_id, @activities.first.id
  end

  def index
    @latest = current_user.latest_activity
  end

end