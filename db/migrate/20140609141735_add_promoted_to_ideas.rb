class AddPromotedToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :promoted, :boolean
  end
end
