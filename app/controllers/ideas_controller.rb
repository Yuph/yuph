# -*- coding: utf-8 -*-
class IdeasController < ApplicationController
  load_and_authorize_resource only: [:edit, :update, :destroy, :new, :show]

  skip_before_filter :authenticate_user!, :only => [:index, :show]

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to idea_path(exception.subject)
  end

  after_filter :create_activities, :only => [:create, :update]

  def create_activities
    @idea.create_activity key: "idea.#{action_name}", owner: current_user unless @idea.errors.any?
  end

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

      redirect_to @idea, notice: t("idea.created"), new_idea: true
    else
      render :new
    end
  end

  def show
    @user = current_user
  end

  def new
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

  def idea_params
    params.require(:idea).permit(:name, :image, :mini_description, :description, :video, :password, :title)
  end
end
