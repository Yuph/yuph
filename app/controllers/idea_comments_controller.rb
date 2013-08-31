class IdeaCommentsController < ApplicationController
before_filter :set_idea_comment, :only => [:edit, :update, :destroy]  
  def index
  end

  def create
    set_session_user
    @idea_comment = IdeaComment.new(idea_comment_params)
    @idea_comment.user_id = @user.id
    if @idea_comment.save
      redirect_to @idea_comment, notice: "Succefully created !"
    else
      render :new
    end
  end

  def show
  	@idea_comment = IdeaComment.find(params[:id])
  end

  def new
    @idea_comment = IdeaComment.new
  end

  def edit
  end

  def update
    if  @idea_comment.update_attributes(idea_comment_params)
      redirect_to @idea_comment, notice: "Updated"
    else
      render :edit
    end
  end

  def destroy
    @idea_comment.destroy
    redirect_to :action => "index"
  end

  def set_idea_comment
    set_session_user
    @idea_comment = IdeaComment.find(params[:id])
    if !@idea_comment.can_managed_by(@user)
      redirect_to action: :index
    end
  end
  def idea_comment_params
    params.require(:idea_comment).permit(:title, :message, :idea_id)
  end
end
