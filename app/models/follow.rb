class Follow < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea

  validates :user, presence: :true
  validates :idea, presence: :true
end
