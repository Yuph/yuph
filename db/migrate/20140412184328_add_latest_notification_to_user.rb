class AddLatestNotificationToUser < ActiveRecord::Migration
  def change
    add_column :users, :latest_activity_id, :integer
  end
end
