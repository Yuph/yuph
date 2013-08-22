class Forum < ActiveRecord::Base
  belongs_to :idea
  has_many :categories

  validates_presence_of :idea
end
