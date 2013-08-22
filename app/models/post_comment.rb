class PostComment < ActiveRecord::Base
  belongs_to :post

  validates_presence_of :title, :message, :post
end
