class UsersController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:new, :create, :show]
  load_and_authorize_resource

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to user_path(exception.subject)
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
  end

  def edit
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

  def user_full_params
    params.require(:user).permit(:email, :password, :password_confirmation, profile_attributes: [:id, :nick, :first_name, :last_name, :image, :about, :local, :website, :facebook, :twitter])
  end
end
