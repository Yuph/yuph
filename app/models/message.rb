class Message < ActiveRecord::Base
  belongs_to :message_receiver, :class_name => 'User'
  belongs_to :message_sender, :class_name => 'User'
  validates_presence_of :title, :body, :message_receiver, :message_sender
end
