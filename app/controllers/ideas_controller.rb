class IdeasController < ApplicationController
  before_filter :set_session_user, :only => [:create, :set_idea]
  before_filter :set_idea, :only => [:show, :edit, :update, :destroy]
  def index
  end
  def create
    @idea = Idea.create(idea_params)
    @idea.users << @user
    if @idea.save!
      redirect_to @idea, notice: "Succefully created !"
    else
      render :new
    end
  end

  def show
  end

  def new
    @idea = Idea.new
  end

  def edit
  end

  def update
    if  @idea.update_attributes(idea_params)
      redirect_to @idea, notice: "Updated"
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
    if !@idea.can_managed_by(@user)
      redirect_to action: :index
    end
  end
  def idea_params
    params.require(:idea).permit(:name, :image, :mini_description, :description, :video, :password)
  end
end
