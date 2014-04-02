class Forum < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :idea
  has_many :categories, :dependent => :delete_all

  validates :idea, presence: :true

  def can_managed_by(user)
    if self.idea.users.where("user_id = ?", user.id).first
      return true
    else
      return false
    end
  end
end
