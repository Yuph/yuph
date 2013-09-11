require 'spec_helper'

describe IdeaAdmin do
  context "action" do
    it "set admins to idea" do
      user = User.create(nick: "victor-antoniazzi", email: "vgsantoniazzi@gmail.com", password: "test123")
      idea = Idea.create(name: "art'n vinil", mini_description: "arte no vinil", description: "bla.. bla.. bla..", image_file_name: "aiehiuae.jpg")
      idea.users << user
      idea.save!
      expect(idea.users.first).to eql(user)
      expect(user.ideas.first).to eql(idea)
      user_two = User.create(nick: "victor-pedro", email: "houhouhou@gmail.com", password: "test123")
      IdeaAdmin.create(user_id: user_two.id, idea_id: idea.id)
      expect(IdeaAdmin.where("idea_id = ?", idea.id).size).to eql(2)
    end
    it "try create with false user and false idea" do
      idea_admin = IdeaAdmin.create(user_id: 982, idea_id: 776)
      expect(idea_admin).to have(1).error_on(:user)
      expect(idea_admin).to have(1).error_on(:idea)
    end
  end
end
