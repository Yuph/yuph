class User < ActiveRecord::Base
  attr_accessor :image_content_type
  attr_accessor :password, :password_confirmation

  before_create :set_hash

  has_many :idea_admins
  has_many :ideas, through: :idea_admins
  has_many :follows
  has_many :following, through: :follows, source: :idea
  has_many :posts
  has_many :idea_comments
  has_many :post_comments
  has_many :comment_sends, :class_name => 'UserComment', :foreign_key => 'comment_sender_id'
  has_many :comment_receives, :class_name => 'UserComment', :foreign_key => 'comment_receiver_id'
  has_many :message_sends, :class_name => 'Message', :foreign_key => 'message_sender_id'
  has_many :message_receives, :class_name => 'Message', :foreign_key => 'message_receiver_id'

  validates :nick, presence: :true, :uniqueness => true
  validates :password, :length => 6..20, confirmation: true, :if => Proc.new{ self.password != self.password_confirmation }
  validates_presence_of :password, :if => Proc.new{ self.new_record? }
  validates :email, presence: :true, :uniqueness => true, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

  has_attached_file :image,
  	:styles => { :medium => "300x300>", :thumb => "100x80#" },
    :storage => :s3,
    :default_url => '/assets/user-default.jpg',
    :bucket => 'yuph',
    :path => "profile/:attachment/:id/:style.:extension",
    :s3_credentials => { :access_key_id => 'AKIAI5MJFU42WK57XFEQ',
                         :secret_access_key => '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' },
    :s3_permissions => 'public-read',
    :s3_host_name => 's3-us-west-2.amazonaws.com'

  validates_attachment :image, :content_type => { :content_type => /^image\/(png|gif|jpeg)/ }

  def set_hash
    if (!self.password.blank?)
      self.access_token = Digest::SHA1.hexdigest("thisissecret#"+self.password)
    end
  end

  def self.login(email, password)
    where("email = ? and access_token = ?", email, Digest::SHA1.hexdigest("thisissecret#"+password)).first
  end
end
