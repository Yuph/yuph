class CreateIdeaAdmins < ActiveRecord::Migration
  def change
    create_table :idea_admins do |t|
      t.references :user
      t.references :idea

      t.timestamps
    end
  end
end
