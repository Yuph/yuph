class IdeaCommentsController < ApplicationController
  before_filter :set_idea_comment, :only => [:destroy]
  respond_to :html, :json

  def create
    set_session_user
    @idea_comment = @user.idea_comments.build(idea_comment_params)
    if @idea_comment.save
    respond_with(@idea_comment, :status => :created) do |format|
        format.html { redirect_to :back, notice: "Succefully created !" }
      end
    else
      respond_with(@idea_comment.errors, :status => :unprocessable_entity) do |format|
          format.html { render :new }
      end
    end
  end

  def destroy
    @idea_comment.destroy
    respond_with(@idea_comment, :status => :deleted) do |format|
      format.html { redirect_to :back, notice: "Succefully Destroyed !" }
    end
  end

  def set_idea_comment
    set_session_user
    @idea_comment = IdeaComment.find(params[:id])
    if !@idea_comment.can_managed_by(@user)
      redirect_to :back
    end
  end

  def idea_comment_params
    params.require(:idea_comment).permit(:title, :message, :idea_id)
  end
end
