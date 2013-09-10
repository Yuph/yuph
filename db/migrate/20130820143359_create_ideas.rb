class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :name
      t.string :image_file_name
      t.text :mini_description
      t.text :description
      t.string :video
      t.string :password

      t.timestamps
    end
  end
end
