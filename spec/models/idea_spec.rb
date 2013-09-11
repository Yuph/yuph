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
      expect(idea).to have(1).error_on(:description)
    end
  end
  context "actions" do
    it "get forum" do
      idea = Idea.create(name: "art'n vinil", mini_description: "arte no vinil", description: "bla.. bla.. bla..", image_file_name: "aiehiuae.jpg")
      forum = Forum.create(idea_id: idea.id)
      expect(idea.forum).to eql(forum)
      expect(forum.idea).to eql(idea)
    end
    it "get admins" do
      idea = Idea.create(name: "art'n vinil", mini_description: "arte no vinil", description: "bla.. bla.. bla..", image_file_name: "aiehiuae.jpg")
      user = User.create(nick: "victor-antoniazzi", email: "vgsantoniazzi@gmail.com", password: "test123")
      idea.users << user
      idea.save!
      expect(idea.users.size).to eql(1)
      expect(user.ideas.size).to eql(1)
    end
  end
end
