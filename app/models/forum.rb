class Forum < ActiveRecord::Base
  belongs_to :idea
  has_many :categories, dependent: :destroy

  validates :idea, presence: :true

  def can_managed_by(user)
    if self.idea.users.where("user_id = ?", user.id).first
      return true
    else
      return false
    end
  end
end
