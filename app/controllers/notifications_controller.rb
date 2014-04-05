class NotificationsController < ApplicationController

  def index
    act = PublicActivity::Activity
    # User owned activity
    @activities = act.where(:owner => current_user)
    # Activity in user ideas
    @activities |= act.where(:trackable_type => 'Idea', :trackable_id => current_user.ideas)
    # Activity in user's ideas forum
    @activities |= act.where(:trackable_type => 'Forum', :trackable_id => current_user.ideas.map(&:forum))
    # Activity in user's followed ideas
    @activities |= act.where(:trackable_type => 'Idea', :trackable_id => current_user.follows.map(&:idea))
  end

end