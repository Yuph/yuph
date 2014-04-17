Profile.all.each do |profile|
  user = profile.user
  if profile.uid && profile.provider &&
     user.uid.blank? && user.provider.blank?
    user.uid = profile.uid
    user.provider = profile.provider
    user.password = Devise.friendly_token[0,20]
    user.save!
  end
end