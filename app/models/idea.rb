class Idea < ActiveRecord::Base
  attr_accessor :image_content_type

  has_many :idea_admins, :dependent => :delete_all
  has_many :users, through: :idea_admins
  has_many :idea_comments, :dependent => :delete_all
  has_many :follows, :dependent => :delete_all
  has_many :followers, through: :follows, source: :user

  has_one :forum, :dependent => :delete

  validates :name, presence: :true
  validates :mini_description, presence: :true
  validates :description, presence: :true

  has_attached_file :image,
  	:styles => { :medium => "300x300>", :thumb => "220x144#" },
    :storage => :s3,
    :default_url => '/assets/missing.png',
    :bucket => 'yuph',
    :path => "idea/:attachment/:id/:style.:extension",
    :s3_credentials => { :access_key_id => 'AKIAI5MJFU42WK57XFEQ',
                         :secret_access_key => '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' },
    :s3_permissions => 'public-read',
    :s3_host_name => 's3-us-west-2.amazonaws.com'

  scope :last_four, -> {self.last(4)}

  def can_managed_by(user)
    if self.users.where("user_id = ?", user.id).first
      return true
    else
      return false
    end
  end
end
