class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :image_content_type

  has_many :idea_admins, :dependent => :delete_all
  has_many :ideas, through: :idea_admins
  has_many :follows, :dependent => :delete_all
  has_many :following, through: :follows, source: :idea
  has_many :posts, :dependent => :delete_all
  has_many :idea_comments, :dependent => :delete_all
  has_many :post_comments, :dependent => :delete_all
  has_many :comment_sends, :class_name => 'UserComment', :foreign_key => 'comment_sender_id', :dependent => :delete_all
  has_many :comment_receives, :class_name => 'UserComment', :foreign_key => 'comment_receiver_id',:dependent => :delete_all
  has_many :message_sends, :class_name => 'Message', :foreign_key => 'message_sender_id', :dependent => :delete_all
  has_many :message_receives, :class_name => 'Message', :foreign_key => 'message_receiver_id',:dependent => :delete_all

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

  has_one :profile

  delegate :nick, :first_name, :last_name, :image_file_name, :about, :local,
    :website, :facebook, :twitter, :provider, :to => :profile

  alias :devise_valid_password? :valid_password?

  def valid_password?(password)
    # Try new login style and fallback to old style for old users
    devise_valid_password?(password) || old_valid_password?(password)
  end

  def following_id(idea)
      self.follows.where('idea_id = ?', idea.id).first.id
  end

  def profile_image
    if !self.image_file_name.blank? && self.image_file_name.include?("graph.facebook")
      "http://graph.facebook.com/#{self.uid}/picture?width=300&height=300"
    else
      self.image.url(:thumb)
    end
  end

  def self.find_or_create_with_omniauth(auth)
    user = self.find_or_create_by_provider_and_uid(auth.provider, auth.uid)
    user.assign_attributes({ nick: auth.info.name, email: auth.info.email, image_file_name: auth.info.image, access_token: auth.credentials.token })
    user
  end

  private
  def old_valid_password?(password)
    if Digest::SHA1.hexdigest(Yuph::USER_SECRET_SALT+password) == self.profile.access_token_login
      logger.info "User #{email} is using the old password hashing method, updating attribute."
      self.password = password
      self.profile.update :updated_user => true
      self.save!
      true
    end
  end
end
