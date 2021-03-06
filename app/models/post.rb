class Post < ActiveRecord::Base
  belongs_to :category
  delegate :forum, to: :category
  belongs_to :user
  has_many :post_comments, :order => 'post_comments.created_at ASC', :dependent => :delete_all

  validates :title, presence: :true
  validates :message, presence: :true
  validates :category, presence: :true
  validates :user, presence: :true

  def can_managed_by(user)
    if self.category.forum.idea.users.where("user_id = ?", user.id).first || self.user_id == user.id
      return true
    else
      return false
    end
  end
end
