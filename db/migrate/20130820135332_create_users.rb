class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nick
      t.string :first_name
      t.string :last_name
      t.string :access_token
      t.string :email
      t.string :image_file_name
      t.text :about
      t.string :local
      t.string :website
      t.string :facebook
      t.string :twitter

      t.timestamps
    end
  end
end
