class Message < ActiveRecord::Base
  belongs_to :message_receiver, :class_name => 'User'
  belongs_to :message_sender, :class_name => 'User'

  validates :title, presence: :true
  validates :body, presence: :true
  validates :message_receiver, presence: :true
  validates :message_sender, presence: :true

  def can_managed_by(user)
    if self.sender == user.id || self.receiver == user.id
      return true
    else
      return false
    end
  end
end
