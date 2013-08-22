class Post < ActiveRecord::Base
  belongs_to :category

  validates_presence_of :title, :message, :category
end
