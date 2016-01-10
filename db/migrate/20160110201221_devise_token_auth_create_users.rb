class DeviseTokenAuthCreateUsers < ActiveRecord::Migration
	def change
		## Database authenticatable
		add_column :users, :tokens, :text
  	end
end
