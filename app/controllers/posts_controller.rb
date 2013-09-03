class PostsController < ApplicationController
  before_filter :set_post, :only => [:edit, :update, :destroy]
  def index
  end

  def create
    set_session_user
    @post = @user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: "Succefully created !"
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def update
    if  @post.update_attributes(post_params)
      redirect_to @post, notice: "Updated"
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to :action => "index"
  end

  def set_post
    set_session_user
    @post = Post.find(params[:id])
    if !@post.can_managed_by(@user)
      redirect_to action: :index
    end
  end

  def post_params
    params.require(:post).permit(:title, :message, :category_id)
  end
end

