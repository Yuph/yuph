class UsersController < ApplicationController

  # For the API authentication
  include RestfulApiAuthentication
  before_filter :load_authorize_and_authenticate_via_key, :if => :api_call?
  respond_to :json, :html

  # authentication via devise and authorization via cancan
  skip_before_filter :authenticate_user!, :only => [:show]
  load_and_authorize_resource

  # skip cookie authentication if it's a api call
  skip_before_filter :authenticate_user!, :if => :api_call?

  # creating activity for notifications
  after_filter :create_activities, :only => [:update]

  def create_activities
    @user.create_activity key: "user.#{action_name}", owner: current_user unless @user.errors.any?
  end

  rescue_from CanCan::AccessDenied do |exception|
    if api_call?
      # error 403 as user is not authorized to perform this action
      render :json => {}, :status => 403
    else
      redirect_to user_path(exception.subject)
    end
  end

  def index
    redirect_to root_path
  end

  # 'create' is on Devise::RegistrationController

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
      redirect_to @user, notice: t('user.updated')
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to :controller => "session", :action => "index"
  end

  # Controller method to show the api key and secret
  # Shold return json too, to be used by the app
  def api
    @user.create_api if @user.api.nil?
    @api_key = @user.api.api_key
    @secret = @user.api.secret
  end

  private

  def load_authorize_and_authenticate_via_key
    @api_key = request.headers['x-api-key']
    @user = RestClient.find_by_api_key(@api_key).try(:user)

    return unless authenticated? && @user.present?
  end

  def user_full_params
    params.require(:user).permit(:email, :password, :password_confirmation, profile_attributes: [:id, :nick, :first_name, :last_name, :image, :about, :local, :website, :facebook, :twitter])
  end
end
