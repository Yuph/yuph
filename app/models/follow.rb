class Follow < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea

  validates_presence_of :idea, :user
end
