class AddProfilesToUsers < ActiveRecord::Migration
  def up
    # At this point User models have been renamed to Profiles
    require 'uuidtools'
    require 'base64'

    Profile.all.each do |p|
      if p.user.nil?
        puts "Creating user #{p.email}"
        uid = UUIDTools::UUID.random_create
        dummy_password = Base64.encode64(uid)[0..64]

        user = User.create(:email => p.email, :profile => p, :password => dummy_password)
        p.user = user
        p.update :updated_user => false # Denotes if the user has updated the password to the new system
        p.save!
      end
    end
  end

  def down
    # raise ActiveRecord::IrreversibleMigration
  end
end
