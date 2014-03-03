class RegistrationsController < Devise::RegistrationsController

  def new
    @user = User.new
    @user.build_profile
  end

  private

  def sign_up_params
    allow = [:email, :your_fields, :password, :password_confirmation, profile_attributes: [:nick]]
    params.require(:user).permit(allow)
  end

end