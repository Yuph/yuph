require 'spec_helper'

describe Follow do
  context "actions" do
    it "succefuly create" do
      user = User.create(nick: "victor-antoniazzi", email: "vgsantoniazzi@gmail.com", password: "test123")
      idea = Idea.create(name: "art'n vinil", mini_description: "arte no vinil", description: "bla.. bla.. bla..", image: "aiehiuae.jpg")
      idea.followers << user
      idea.save!
      expect(idea.followers.size).to eql(1)
      expect(user.following.size).to eql(1)
    end
  end
  context "get follows" do
    it "by user" do
      user = User.create(nick: "victor-antoniazzi", email: "vgsantoniazzi@gmail.com", password: "test123")
      idea_one = Idea.create(name: "art'n vinil", mini_description: "arte no vinil", description: "bla.. bla.. bla..", image: "aiehiuae.jpg")
      idea_two = Idea.create(name: "art'n vinil", mini_description: "arte no vinil", description: "bla.. bla.. bla..", image: "aiehiuae.jpg")
      idea_one.followers << user
      idea_two.followers << user
      idea_one.save!
      idea_two.save!
      expect(user.following.size).to eql(2)
    end
    it "by idea" do
      user_one = User.create(nick: "victor-antoniazzi", email: "vgsantoniazzi@gmail.com", password: "test123")
      user_two = User.create(nick: "victor-antoniazzi", email: "vgsantoniazzi@gmail.com", password: "test123")
      idea = Idea.create(name: "art'n vinil", mini_description: "arte no vinil", description: "bla.. bla.. bla..", image: "aiehiuae.jpg")
      idea.followers << user_one
      idea.followers << user_two
      idea.save!
      expect(idea.followers.size).to eql(2)
    end
  end
end
