class UsersController < ApplicationController
  before_filter :set_user, :only => [:edit, :update, :destroy]
  skip_before_filter :authenticate_user!, :only => [:new, :create, :show]

  def index
  end

  def create
    @user = User.new(user_single_params)
    if @user.save
      redirect_to new_idea_path, notice: "Succefully created !"
    else
      render :new
    end
  end

  def show
    @session_user = current_user
    @user = User.find(params[:id])
  end

  def edit
    puts current_user.inspect
  end

  def update
    # Let devise save it without password
    user_params = user_full_params
    if user_params[:password].blank? && user_params[:password_confirmation].blank?
      user_params.delete(:password)
      user_params.delete(:password_confirmation)
    end

    if  @user.update_attributes(user_params)
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

  def user_full_params
    params.require(:user).permit(:email, :password, :password_confirmation, profile_attributes: [:id, :nick, :first_name, :last_name, :image, :about, :local, :website, :facebook, :twitter])
  end
end
