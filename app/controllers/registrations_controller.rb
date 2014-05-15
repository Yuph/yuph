class RegistrationsController < Devise::RegistrationsController

  def new
    @user = User.new
    @user.build_profile
  end

  private

  def sign_up_params
    allow = [:email, :password, :password_confirmation, profile_attributes: [:nick]]
    params.require(:user).permit(allow)
  end

  protected

  def after_sign_up_path_for(resource)
    root_path(:new_user => true)
  end

  def after_sign_in_path_for(resource)
    sign_in_url = url_for(:action => 'new', :controller => 'sessions', :only_path => false, :protocol => 'http')
    if request.referer == sign_in_url
      super
    else
      request.env['omniauth.origin'] || stored_location_for(resource) || request.referer || root_path
    end
  end
end