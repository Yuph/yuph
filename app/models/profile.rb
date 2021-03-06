class Profile < ActiveRecord::Base
  belongs_to :user, :dependent => :destroy

  validates :nick, presence: :true, :uniqueness => true

  has_attached_file :image,
    :styles => { :medium => "300x300>", :thumb => "100x80#" },
    :storage => :s3,
    :default_url => '/assets/user-default.jpg',
    :bucket => ENV['S3_BUCKET_NAME'],
    :path => "profile/:attachment/:id/:style.:extension",
    :s3_permissions => 'public-read',
    :s3_host_name => 's3-us-west-2.amazonaws.com'

  attr_accessor :image_content_type
  validates_attachment :image, :content_type => { :content_type => /^image\/(png|gif|jpeg)/ }
end