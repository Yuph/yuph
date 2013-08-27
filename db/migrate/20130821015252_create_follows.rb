class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.references :user
      t.references :idea

      t.timestamps
    end
    add_index :follows, :user_id
    add_index :follows, :idea_id
  end
end
