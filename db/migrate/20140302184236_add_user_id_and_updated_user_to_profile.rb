class AddUserIdAndUpdatedUserToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :user_id, :integer
    add_column :profiles, :updated_user, :boolean
  end
end
