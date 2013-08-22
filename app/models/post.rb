class Post < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :post_comments

  validates_presence_of :title, :message, :category, :user
end
