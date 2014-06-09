class MoveOauthDataFromProfileToUsers < ActiveRecord::Migration
  def up
    Profile.all.each do |profile|
      user = profile.user
      if profile.uid && profile.provider && user.uid.blank? && user.provider.blank?
        puts "#{user.email} #{profile.uid} #{profile.provider}"
        user.uid = profile.uid
        user.provider = profile.provider
        user.password = Devise.friendly_token[0,20]
        user.save!
      end
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
