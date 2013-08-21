class IdeaComment < ActiveRecord::Base

  belongs_to :user
  belongs_to :idea
  validates_presence_of :title, :message, :user, :idea
end
