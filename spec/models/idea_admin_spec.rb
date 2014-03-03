require 'spec_helper'

describe IdeaAdmin do
  context "action" do
    it "set admins to idea" do
      user = FactoryGirl.create(:user)
      idea = FactoryGirl.create(:idea)
      idea.users << user
      expect(idea.users.first).to eql(user)
      expect(user.ideas.first).to eql(idea)
      user_two = FactoryGirl.create(:user)
      FactoryGirl.create(:idea_admin, user_id: user_two.id, idea_id: idea.id)
      expect(IdeaAdmin.where("idea_id = ?", idea.id).size).to eql(2)
    end
    it "try create with false user and false idea" do
      idea_admin = FactoryGirl.build(:idea_admin, user_id: 982, idea_id: 776)
      expect(idea_admin).to have(1).error_on(:user)
      expect(idea_admin).to have(1).error_on(:idea)
    end
  end
end
