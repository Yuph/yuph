class PostCommentsController < ApplicationController
  before_filter :set_post_comment, :only => [:edit, :update, :destroy]

  def index
  end

  def create
    set_session_user
    @post_comment = @user.post_comments.build(post_comment_params)
    if @post_comment.save
      redirect_to :back, notice: "Succefully created !"
    else
      redirect_to :back
    end
  end

  def show
    @post_comment = PostComment.find(params[:id])
  end

  def new
    @post_comment = PostComment.new
  end

  def edit
  end

  def update
    if  @post_comment.update_attributes(post_comment_params)
      redirect_to @post_comment, notice: "Updated"
    else
      render :edit
    end
  end

  def destroy
    @post_comment.destroy
    redirect_to :back
  end

  def set_post_comment
    set_session_user
    @post_comment = PostComment.find(params[:id])
    if !@post_comment.can_managed_by(@user)
      redirect_to action: :index
    end
  end

  def post_comment_params
    params.require(:post_comment).permit(:title, :message, :post_id)
  end
end

