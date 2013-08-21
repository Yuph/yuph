class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.references :user
      t.references :idea

      t.timestamps
    end
  end
end
