class IdeaAdminsController < ApplicationController
  before_filter :set_idea_admin, :only => [:edit, :update, :destroy]
    def index
    end

    def create
      set_session_user
      @idea_admin = IdeaAdmin.new(idea_admin_params)
      @idea_admin.user_id = @user.id
      if @idea_admin.save
        redirect_to @idea_admin, notice: "Succefully created !"
      else
        render :new
      end
    end

    def show
    	@idea_admin = IdeaAdmin.find(params[:id])
    end

    def new
      @idea_admin = IdeaAdmin.new
    end

    def edit
    end

    def update
      if  @idea_admin.update_attributes(idea_admin_params)
        redirect_to @idea_admin, notice: "Updated"
      else
        render :edit
      end
    end

    def destroy
      @idea_admin.destroy
      redirect_to :action => "index"
    end

    def set_idea_admin
      set_session_user
      @idea_admin = IdeaAdmin.find(params[:id])
      if @idea_admin.user != @user
        redirect_to action: :index
      end
    end
    def idea_admin_params
      params.require(:idea_admin).permit(:idea_id)
    end
  end
