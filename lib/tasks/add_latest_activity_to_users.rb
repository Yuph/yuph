User.all.each do |u|
  u.latest_activity_id = u.latest_activities.first.try(:id)
end