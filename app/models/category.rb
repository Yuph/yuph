class Category < ActiveRecord::Base
  belongs_to :forum
  has_many :posts, dependent: :destroy

  validates :forum, presence: :true
  validates :title, presence: :true

  def can_managed_by(user)
    if self.forum.idea.users.where("user_id = ?", user.id).first
      return true
    else
      return false
    end
  end
end
