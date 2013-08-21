class CreateUserComments < ActiveRecord::Migration
  def change
    create_table :user_comments do |t|
      t.string :title
      t.text :message
      t.integer :sender_id, :references => "user"
      t.integer :receiver_id, :references => "user"

      t.timestamps
    end
  end
end
