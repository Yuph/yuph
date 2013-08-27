class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title
      t.string :description
      t.references :forum

      t.timestamps
    end
      add_index :categories, :forum_id
  end
end
