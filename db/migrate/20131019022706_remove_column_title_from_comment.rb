class RemoveColumnTitleFromComment < ActiveRecord::Migration
  def change
  	remove_column :user_comments, :title
  	remove_column :idea_comments, :title
  end
end
