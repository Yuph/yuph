class IdeaComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea

  validates :user, presence: :true
  validates :idea, presence: :true
  validates :title, presence: :true
  validates :message, presence: :true

  def can_managed_by(user)
    if self.idea.users.where("user_id = ?", user.id).first || self.user_id == user.id
      return true
    else
      return false
    end
  end
end
