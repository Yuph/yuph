class NotificationsController < ApplicationController

  def index
    @activities = PublicActivity::Activity.all
  end

end