class RemoveProviderAndUidAndEmailFromProfile < ActiveRecord::Migration
  def change
    remove_column :profiles, :provider, :string
    remove_column :profiles, :uid, :string
    remove_column :profiles, :email, :string
  end
end
