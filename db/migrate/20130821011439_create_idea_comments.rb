class CreateIdeaComments < ActiveRecord::Migration
  def change
    create_table :idea_comments do |t|
      t.string :title
      t.string :message
      t.references :idea
      t.references :user

      t.timestamps
    end
    add_index :idea_comments, :user_id
    add_index :idea_comments, :idea_id
  end
end
