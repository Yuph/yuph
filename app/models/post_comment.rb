class PostComment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates_presence_of :title, :message, :post, :user
end
