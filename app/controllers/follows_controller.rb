class FollowsController < ApplicationController
  before_filter :set_follow, :only => [:destroy]
  respond_to :html, :json

  after_filter :create_activities, :only => [:create, :destroy]

  def create_activities
    @follow.idea.create_activity key: "idea.follow_#{action_name}",
      owner: current_user, params: { follow_id: @follow.id } unless @follow.errors.any?
  end

  def index
  end

  def create
    set_session_user
    @follow = @user.follows.build(follow_params)
    if @follow.save
      respond_with(@follow, :status => :created) do |format|
        format.html { redirect_to :back, notice: "Succefully created !" }
      end
    else
      respond_with(@follow.errors, :status => :unprocessable_entity) do |format|
        format.html { redirect_to :back }
      end
    end
  end

  def destroy
    @follow.destroy
    respond_with(@follow, :status => :deleted) do |format|
      format.html { redirect_to :back, notice: "Succefully Destroyed !" }
    end
  end

  def set_follow
    set_session_user
    @follow = Follow.find(params[:id])
    if @follow.user != @user
      redirect_to :back
    end
  end

  def follow_params
    params.require(:follow).permit(:idea_id)
  end
end

