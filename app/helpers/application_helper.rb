module ApplicationHelper

  def logged?
    current_user
  end

  def following?
    if !@user.blank? && @user.following.where('idea_id = ?', @idea.id).blank?
      true
    else
      false
    end
  end
end
