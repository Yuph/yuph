class ForumController < ApplicationController
  before_filter :set_idea, :only => [:create]
  before_filter :set_forum, :only => [:edit, :update, :destroy]

  def index
  end

  def create
    set_session_user
    @forum = Forum.new(forum_params)
    @forum.save
    redirect_to @forum, notice: "Succefully created !"
  end

  def show
    #Criar regra de password
    @forum = Forum.find(params[:id])
  end

  def new
    @forum = Forum.new
  end

  def edit
  end

  def update
    @forum.update_attributes(forum_params)
    redirect_to @forum, notice: "Updated"
  end

  def destroy
    @forum.destroy
    redirect_to :action => "index"
  end

  def set_idea
    set_session_user
    @idea = Idea.find(params[:forum][:idea_id])
    if !@idea.can_managed_by(@user)
      redirect_to action: :index
    end
  end

  def set_forum
    set_session_user
    @forum = Forum.find(params[:id])
    if !@forum.can_managed_by(@user)
      redirect_to action: :index
    end
  end

  def forum_params
    params.require(:forum).permit(:idea_id, :password)
  end
end
