require 'spec_helper'

describe Idea do
  context "validate presence of" do
    it "name" do
      idea = Idea.create
      expect(idea).to have(1).error_on(:name)
    end
    it "mini_description" do
      idea = Idea.create
      expect(idea).to have(1).error_on(:mini_description)
    end
    it "description" do
      idea = Idea.create
      # expect(idea).to have(1).error_on(:description)
    end
  end
  context "actions" do
    it "get forum" do
      idea = FactoryGirl.create(:idea)
      forum = FactoryGirl.create(:forum, idea_id: idea.id)
      expect(idea.forum).to eql(forum)
      expect(forum.idea).to eql(idea)
    end
    it "get admins" do
      idea = FactoryGirl.create(:idea)
      user = FactoryGirl.create(:user)
      idea.users << user
      idea.save!
      expect(idea.users.size).to eql(1)
      expect(user.ideas.size).to eql(1)
    end
  end
end
