class Category < ActiveRecord::Base
  belongs_to :forum
  has_many :posts

  validates_presence_of :forum, :title, :description
end
