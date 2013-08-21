class CreateIdeaComments < ActiveRecord::Migration
  def change
    create_table :idea_comments do |t|
      t.string :title
      t.string :message
      t.references :idea
      t.references :user

      t.timestamps
    end
  end
end
