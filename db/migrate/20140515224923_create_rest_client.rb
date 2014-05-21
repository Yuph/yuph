class CreateRestClient < ActiveRecord::Migration
  def change
    create_table :rest_clients do |t|
      t.string :api_key
      t.string :secret
      t.boolean :is_master
      t.boolean :is_disabled
      t.integer :user_id
      t.timestamps
    end
  end
end
