User.all.each do |u|
  u.created_at = u.profile.created_at
  u.save!
end