class Category < ActiveRecord::Base
  belongs_to :forum

  validates_presence_of :forum, :title, :description
end
