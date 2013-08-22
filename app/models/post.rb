class Post < ActiveRecord::Base
  belongs_to :category
  has_many :post_comments

  validates_presence_of :title, :message, :category
end
