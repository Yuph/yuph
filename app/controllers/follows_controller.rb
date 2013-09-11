class FollowsController < ApplicationController
  before_filter :set_follow, :only => [:edit, :update, :destroy]
  respond_to :html, :json

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
        format.html { render :action => :new }
      end
    end
  end

  def show
    @follow = Follow.find(params[:id])
  end

  def new
    @follow = Follow.new
  end

  def edit
  end

  def update
    if  @follow.update_attributes(follow_params)
      redirect_to @follow, notice: "Updated"
    else
      render :edit
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
      redirect_to action: :index
    end
  end

  def follow_params
    params.require(:follow).permit(:idea_id)
  end
end

