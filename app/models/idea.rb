class Idea < ActiveRecord::Base

  validates_presence_of :name, :image, :mini_description, :description
end
