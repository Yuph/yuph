class UserComment < ActiveRecord::Base
  belongs_to :comment_sender, :class_name => 'User'
  belongs_to :comment_receiver, :class_name => 'User'

  validates_presence_of :comment_sender, :comment_receiver, :title, :message

  def can_managed_by(user)
    if self.comment_receiver_id == user.id || self.comment_sender_id == user.id
      return true
    else
      return false
    end
  end
end
