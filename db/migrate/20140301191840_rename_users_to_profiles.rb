class RenameUsersToProfiles < ActiveRecord::Migration
  def change
    rename_table :users, :profiles
  end
end
