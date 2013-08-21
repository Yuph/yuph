require 'spec_helper'

describe IdeaComment do
  context "validate presence of" do
    it "title" do
      idea_comment = IdeaComment.create
      expect(idea_comment).to have(1).error_on(:title)
    end
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
      expect(idea_comment).to have(1).error_on(:title)
    end
  end
  context "actions" do
    it "succefully created" do
      user = User.create(nick: "victor-antoniazzi", email: "vgsantoniazzi@gmail.com", password: "test123")
      idea = Idea.create(name: "art'n vinil", mini_description: "arte no vinil", description: "bla.. bla.. bla..", image: "aiehiuae.jpg")
      idea_comment = IdeaComment.create(user_id: user.id, idea_id: idea.id, message: "muito bacana!", title: "Gostei!")
      expect(idea_comment).to have(:no).error
    end
    it "try create with false user and false idea" do
      idea_comment = IdeaComment.create(user_id: 3452, idea_id: 4533, message: "muito bacana!", title: "Gostei!")
      expect(idea_comment).to have(2).error
    end
  end
end
