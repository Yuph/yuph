class User < ActiveRecord::Base

  validates_presence_of :nick, :email, :password
  validates :password, :length => 6..20
end
