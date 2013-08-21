class UserComment < ActiveRecord::Base
  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'

  validates_presence_of :sender, :receiver, :title, :message
end
