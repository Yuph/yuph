module ApplicationHelper
	def logged?
		if session[:user]
			true
		else
			false
		end
	end
  def following?
    if @user.following.where('idea_id = ?', @idea.id).blank?
      true
    else
      false
    end
  end
end
