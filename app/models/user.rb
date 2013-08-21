class User < ActiveRecord::Base
  before_create :set_hash

  has_many :idea_admins
  has_many :idea_comments
  has_many :follows
  has_many :comment_sends, :class_name => 'UserComment', :foreign_key => 'comment_sender_id'
  has_many :comment_receives, :class_name => 'UserComment', :foreign_key => 'comment_receiver_id'
  has_many :message_sends, :class_name => 'Message', :foreign_key => 'message_sender_id'
  has_many :message_receives, :class_name => 'Message', :foreign_key => 'message_receiver_id'

  validates_presence_of :nick, :email, :password
  validates :password, :length => 6..20
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

  def set_hash
    self.password = Digest::SHA1.hexdigest("thisissecret#"+self.password)
  end

  def self.login(email, password)
    where("email = ? and password = ?", email, Digest::SHA1.hexdigest("thisissecret#"+password)).first
  end
end
