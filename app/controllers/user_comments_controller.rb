class UserCommentsController < ApplicationController
  before_filter :set_user_comment, :only => [:destroy]
  respond_to :html, :json

  def create
    set_session_user
    @user_comment = @user.comment_sends.build(user_comment_params)
    if @user_comment.save
      respond_with(@user_comment, :status => :created) do |format|
        format.html { redirect_to :back, notice: "Succefully created !" }
      end
    else
      respond_with(@user_comment.errors, :status => :unprocessable_entity) do |format|
          format.html { render :new }
      end
    end
  end

  def destroy
    @user_comment.destroy
    respond_with(@user_comment, :status => :deleted) do |format|
      format.html { redirect_to :back, notice: "Succefully Destroyed !" }
    end
  end

  def set_user_comment
    set_session_user
    @user_comment = UserComment.find(params[:id])
    if !@user_comment.can_managed_by(@user)
      redirect_to :back
    end
  end

  def user_comment_params
    params.require(:user_comment).permit(:title, :message, :comment_receiver_id)
  end
end
