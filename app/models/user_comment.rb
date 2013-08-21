class UserComment < ActiveRecord::Base
  belongs_to :comment_sender, :class_name => 'User'
  belongs_to :comment_receiver, :class_name => 'User'

  validates_presence_of :comment_sender, :comment_receiver, :title, :message
end
