class CreateIdeaAdmins < ActiveRecord::Migration
  def change
    create_table :idea_admins do |t|
      t.references :user
      t.references :idea

      t.timestamps
    end
    add_index :idea_admins, :user_id
    add_index :idea_admins, :idea_id
  end
end
