
class UserCommentsController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :json

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to user_comments_path(current_user)
  end

  def create
    @user_comment = current_user.comment_sends.build(user_comment_params)
    if @user_comment.save
      respond_with(@user_comment, :status => :created) do |format|
        format.html { redirect_to :back, notice: t('user_comment.created') }
      end
    else
      respond_with(@user_comment, :status => :unprocessable_entity) do |format|
          format.html { redirect_to :back }
      end
    end
  end

  def destroy
    @user_comment.destroy
    respond_with(@user_comment, :status => :deleted) do |format|
      format.html { redirect_to :back, notice: t('user_comment.destroyed') }
    end
  end

  def user_comment_params
    params.require(:user_comment).permit(:message, :comment_receiver_id)
  end
end
