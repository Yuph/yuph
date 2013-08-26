class PostComment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates_presence_of :title, :message, :post, :user

  def can_managed_by(user)
    if self.post.category.forum.idea.users.where("user_id = ?", user.id).first || self.user_id == user.id
      return true
    else
      return false
    end
  end
end
