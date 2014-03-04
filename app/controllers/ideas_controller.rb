# -*- coding: utf-8 -*-
class IdeasController < ApplicationController
  before_filter :set_idea, :only => [:edit, :update, :destroy]
  skip_before_filter :authenticate_user!, :only => [:index, :show]

  def index
    @ideas = Idea.all
  end

  def create
    @idea = Idea.create(idea_params)

    if !@idea.new_record? && @idea.users << current_user && @idea.save
      @forum = Forum.create(idea: @idea)
      @forum.categories.default_category('off-topic').save!
      @forum.categories.default_category('suggestion').save!
      @forum.categories.default_category('brainstorm').save!
      @forum.categories.default_category('general').save!

      redirect_to @idea, notice: t("idea.created")
    else
      render :new
    end
  end

  def show
    @user = current_user
    @idea = Idea.find(params[:id])
  end

  def new
    @idea = Idea.new
  end

  def edit
  end

  def update
    if  @idea.update_attributes(idea_params)
      redirect_to @idea, notice: t("idea.updated")
    else
      render :edit
    end
  end

  def destroy
    @idea.destroy
    redirect_to :action => "index"
  end

  def set_idea
    @idea = Idea.find(params[:id])
    if !@idea.can_managed_by(current_user)
      redirect_to action: :index
    end
  end

  def idea_params
    params.require(:idea).permit(:name, :image, :mini_description, :description, :video, :password, :title)
  end
end
