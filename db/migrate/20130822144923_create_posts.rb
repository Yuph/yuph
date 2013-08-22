class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :message
      t.references :category
      t.references :user

      t.timestamps
    end
  end
end
