class CreatePostComments < ActiveRecord::Migration
  def change
    create_table :post_comments do |t|
      t.string :title
      t.text :message
      t.references :post
      t.references :user

      t.timestamps
    end
      add_index :post_comments, :user_id
      add_index :post_comments, :post_id
  end
end
