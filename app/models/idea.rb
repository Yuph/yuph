class Idea < ActiveRecord::Base
  has_many :idea_admins
  has_many :idea_comments
  has_many :follows

  validates_presence_of :name, :image, :mini_description, :description
end
