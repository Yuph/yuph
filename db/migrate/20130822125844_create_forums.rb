class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.string :password
      t.references :idea

      t.timestamps
    end
    add_index :forums, :idea_id
  end
end
