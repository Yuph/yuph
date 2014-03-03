class UsersController < ApplicationController
  before_filter :set_user, :only => [:edit, :update, :destroy]
  #skip_before_filter :authenticate_user!, :only => [:new, :create, :show]

  def index
  end

  def create
    @user = User.new(user_single_params)
    if @user.save
      session[:user] = @user.id
      redirect_to new_idea_path, notice: "Succefully created !"
    else
      render :new
    end
  end

  def show
    @session_user = User.find(session[:user]) if session[:user]
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if  @user.update_attributes(user_full_params)
      redirect_to @user, notice: "Updated"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to :controller => "session", :action => "index"
  end

  def set_user
    @user = User.find(params[:id])
    if current_user.id != @user.id
      redirect_to action: :index
    end
  end

  def user_single_params
    params.require(:user).permit(:nick, :email, :password, :password_confirmation)
  end

  def user_full_params
    params.require(:user).permit(:nick, :email, :first_name, :last_name, :password, :password_confirmation, :image, :about, :local, :website, :facebook, :twitter)
  end
end
