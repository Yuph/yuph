class Category < ActiveRecord::Base
  belongs_to :forum
  has_many :posts, :dependent => :delete_all

  validates :forum, presence: true
  validates :title, presence: true

  def self.default_category(type, opt = {})
      {
        'off-topic' => FactoryGirl.build(:off_topic_category, opt),
        'suggestion' => FactoryGirl.build(:suggestion_category, opt),
        'brainstorm' => FactoryGirl.build(:brainstorm_category, opt),
        'general' => FactoryGirl.build(:general_category, opt)
      }[type]
  end

  def can_managed_by(user)
    if self.forum.idea.users.where("user_id = ?", user.id).first
      return true
    else
      return false
    end
  end
end
