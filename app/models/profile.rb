class Profile < ActiveRecord::Base
  belongs_to :user, :dependent => :destroy

  validates :nick, presence: :true, :uniqueness => true
end