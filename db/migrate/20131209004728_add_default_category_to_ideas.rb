class AddDefaultCategoryToIdeas < ActiveRecord::Migration
  def up
    Forum.find_each do |forum|
      forum.categories.build(:title => "Off-topic").save!
      forum.categories.build(:title => "Sugestoes").save!
      forum.categories.build(:title => "Brainstorm").save!
      forum.categories.build(:title => "Geral").save!
    end
  end

  def down
  end
end
