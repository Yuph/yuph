# -*- coding: utf-8 -*-
class PostsController < ApplicationController
  before_filter :set_post, :only => [:edit, :update, :destroy]

  after_filter :create_activities, :only => [:create, :update, :destroy]

  def create_activities
    @post.forum.create_activity key: "forum.post_#{action_name}",
      owner: current_user, params: {post_id: @post.id, category_id: @post.category.id } unless @post.errors.any?
  end

  def index
  end

  def create
    set_session_user
    @post = @user.posts.build(post_params)
    if @post.save
      redirect_to :back, notice: t('post.created')
    else
      redirect_to new_post_path, notice: t('post.created_error')
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
      redirect_to @post, notice: t('post.updated')
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to :back
  end

  def set_post
    set_session_user
    @post = Post.find(params[:id])
    if !@post.can_managed_by(@user)
      redirect_to :back, notice: t('post.access_denied')
    end
  end

  def post_params
    params.require(:post).permit(:title, :message, :category_id)
  end
end

