class FollowsController < ApplicationController
  before_filter :set_follow, :only => [:edit, :update, :destroy]
  def index
  end

  def create
    set_session_user
    @follow = @user.follows.build(follow_params)
    if @follow.save
      redirect_to @follow, notice: "Succefully created !"
    else
      render :new
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
    redirect_to :action => "index"
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

