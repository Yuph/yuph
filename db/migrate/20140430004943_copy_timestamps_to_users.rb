class CopyTimestampsToUsers < ActiveRecord::Migration
  def up
    User.all.each do |u|
      u.created_at = u.profile.created_at
      u.save!
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
