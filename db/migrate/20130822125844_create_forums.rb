class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.string :password
      t.references :idea

      t.timestamps
    end
  end
end
