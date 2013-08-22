class Idea < ActiveRecord::Base
  has_many :idea_admins
  has_many :users, through: :idea_admins
  has_many :idea_comments
  has_many :follows
  has_many :followers, through: :follows, source: :user
  has_one :forum

  validates_presence_of :name, :image, :mini_description, :description
end
