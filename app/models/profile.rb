class Profile < ActiveRecord::Base
  belongs_to :user, :dependent => :destroy

  validates :nick, presence: :true, :uniqueness => true

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

  attr_accessor :image_content_type
  validates_attachment :image, :content_type => { :content_type => /^image\/(png|gif|jpeg)/ }
end