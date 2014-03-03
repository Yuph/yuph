require 'spec_helper'

describe Follow do
  context "actions" do
    it "succefuly create" do
      user = FactoryGirl.create(:user)
      idea = FactoryGirl.create(:idea)
      idea.followers << user
      idea.save
      expect(idea.followers.size).to eql(1)
      expect(user.following.size).to eql(1)
    end
  end
  context "get follows" do
    it "by user" do
      user = FactoryGirl.create(:user)
      idea_one = FactoryGirl.create(:idea)
      idea_two = FactoryGirl.create(:idea)
      idea_one.followers << user
      idea_two.followers << user
      expect(user.following.size).to eql(2)
    end
    it "by idea" do
      user_one = FactoryGirl.create(:user)
      user_two = FactoryGirl.create(:user)
      idea = FactoryGirl.create(:idea)
      idea.followers << user_one
      idea.followers << user_two
      expect(idea.followers.size).to eql(2)
    end
  end
end
