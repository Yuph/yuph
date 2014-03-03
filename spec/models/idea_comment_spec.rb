require 'spec_helper'

describe IdeaComment do
  context "validate presence of" do
    it "message" do
      idea_comment = IdeaComment.create
      expect(idea_comment).to have(1).error_on(:message)
    end
    it "user" do
      idea_comment = IdeaComment.create
      expect(idea_comment).to have(1).error_on(:user)
    end
    it "idea" do
      idea_comment = IdeaComment.create
      expect(idea_comment).to have(1).error_on(:idea)
    end
  end
  context "actions" do
    it "succefully created" do
      user = FactoryGirl.create(:user)
      idea = FactoryGirl.create(:idea)
      idea_comment = IdeaComment.create(user_id: user.id, idea_id: idea.id, message: "muito bacana!")
      expect(idea_comment).to have(:no).error
    end
    it "try create with false user and false idea" do
      idea_comment = IdeaComment.create(user_id: 3452, idea_id: 4533, message: "muito bacana!")
      expect(idea_comment).to have(2).error
    end
  end
end
