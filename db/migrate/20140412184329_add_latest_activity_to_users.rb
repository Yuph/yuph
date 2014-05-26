class AddLatestActivityToUsers < ActiveRecord::Migration
  def up
    User.all.each do |u|
      u.latest_activity_id = u.latest_activities.first.try(:id)
      u.save!
    end
  end

  def down
    # raise ActiveRecord::IrreversibleMigration
  end
end
