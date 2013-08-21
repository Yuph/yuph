class User < ActiveRecord::Base
  before_create :set_hash

  has_many :idea_admins
  has_many :idea_comments
  has_many :follows

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
