require 'spec_helper'

describe Follow do
  context "actions" do
    it "succefuly create" do
      user = User.create(nick: "victor-antoniazzi", email: "vgsantoniazzi@gmail.com", password: "test123")
      idea = Idea.create(name: "art'n vinil", mini_description: "arte no vinil", description: "bla.. bla.. bla..", image: "aiehiuae.jpg")
      follow = Follow.create(user_id: user.id, idea_id: idea.id)
      expect(follow).to have(:no).error
    end
    it "fail create" do
      follow = Follow.create(user_id: 34534, idea_id: 34534)
      expect(follow).to have(2).error
    end
  end
  context "get follows" do
    it "by user" do
      user = User.create(nick: "victor-antoniazzi", email: "vgsantoniazzi@gmail.com", password: "test123")
      idea_one = Idea.create(name: "art'n vinil", mini_description: "arte no vinil", description: "bla.. bla.. bla..", image: "aiehiuae.jpg")
      idea_two = Idea.create(name: "art'n vinil", mini_description: "arte no vinil", description: "bla.. bla.. bla..", image: "aiehiuae.jpg")
      Follow.create(user_id: user.id, idea_id: idea_one.id)
      Follow.create(user_id: user.id, idea_id: idea_two.id)
      expect(user.follows.size).to eql(2)
    end
    it "by idea" do
      user_one = User.create(nick: "victor-antoniazzi", email: "vgsantoniazzi@gmail.com", password: "test123")
      user_two = User.create(nick: "victor-antoniazzi", email: "vgsantoniazzi@gmail.com", password: "test123")
      idea = Idea.create(name: "art'n vinil", mini_description: "arte no vinil", description: "bla.. bla.. bla..", image: "aiehiuae.jpg")
      Follow.create(user_id: user_one.id, idea_id: idea.id)
      Follow.create(user_id: user_two.id, idea_id: idea.id)
      expect(idea.follows.size).to eql(2)
    end
  end
end
