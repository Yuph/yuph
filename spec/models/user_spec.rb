require 'spec_helper'

describe User do
  context "validate presence of" do
    it "nickname" do
      user = User.create
      expect(user).to have(1).error_on(:nick)
    end
    it "password" do
      user = User.create
      expect(user).to have(2).error_on(:password)
    end
    it "email" do
      user = User.create
      expect(user).to have(2).error_on(:email)
    end
  end
  context "validate length of" do
    it "password with 5 characters" do
      user = User.create(password: "12345")
      expect(user).to have(1).error_on(:password)
    end
    it "password between 6 and 20" do
      user = User.create(password: "123456")
      expect(user).to have(0).error_on(:password)
    end
    it "password more than 20" do
      user = User.create(password: "123457890123456789012")
      expect(user).to have(1).error_on(:password)
    end
  end
  context "validate email" do
    it "correct" do
      user = User.create(email: "victor@victorantoniazzi.com.br")
      expect(user).to have(0).error_on(:email)
    end
    it "incorrect" do
      user = User.create(email: "victor.com.br")
      expect(user).to have(1).error_on(:email)
    end
  end
  context "hash password" do
    it "getting my hash" do
      User.create(nick: "victor-antoniazzi", email: "vgsantoniazzi@gmail.com", password: "test123")
      user = User.last
      expect(user.password).to eql("3b3de67e92efc05a96b7b40b450bcd179040c4f9")
    end
  end
  context "login" do
    before do
      User.create(nick: "victor-antoniazzi", email: "vgsantoniazzi@gmail.com", password: "test123")
    end
    it "pass" do
      user = User.login("vgsantoniazzi@gmail.com", "test123")
      expect(user.email).to eql("vgsantoniazzi@gmail.com")
    end
    it "try invalid" do
      user = User.login("vgsantoniazzi@gmail.com", "test1234")
      expect(user).to be nil
    end
  end
  context "actions" do
    before do
      @user = User.create(nick: "victor-antoniazzi", email: "vgsantoniazzi@gmail.com", password: "test123")
      @user_two = User.create(nick: "antoniazzi", email: "vgazzi@gmail.com", password: "test123")
      @idea = Idea.create(name: "art'n vinil", mini_description: "arte no vinil", description: "bla.. bla.. bla..", image: "aiehiuae.jpg")
      @forum = Forum.create(idea_id: @idea.id)
      @category = Category.create(title: "o que acharam??", description: "about project", forum_id: @forum.id)
      @post = Post.create(title: "Muito legal!!!", message: "Poo!!", category_id: @category.id, user_id: @user.id)
      @post_two = Post.create(title: "Muito legal!!!", message: "Poo!!", category_id: @category.id, user_id: @user_two.id)
      @post_comment = PostComment.create(title: "Muito legal!!!", message: "Poo!!", post_id: @post.id, user_id: @user_two.id)
      @post_comment_two = PostComment.create(title: "Muito legal!!!", message: "Poo!!", post_id: @post_two.id, user_id: @user.id)
      @idea_comment = IdeaComment.create(user_id: @user.id, idea_id: @idea.id, message: "muito bacana!", title: "Gostei!")
      @message = Message.create(title: "serio xiru?", body: "como tu fez isso?", message_receiver_id: @user_two.id, message_sender_id: @user.id)
      @user_comment = UserComment.create(title: "serio xiru?", message: "como tu fez isso?", comment_receiver_id: @user_two.id, comment_sender_id: @user.id)
      @user.ideas << @idea
      @user.following << @idea
      @user.password = "test123"
      @user.save!
    end
    it "get ideas" do
      expect(@user.ideas.size).to eql(1)
      expect(@user.ideas.last).to eql(@idea)
    end
    it "get idea_comments" do
      expect(@user.idea_comments.size).to eql(1)
      expect(@user.idea_comments.last).to eql(@idea_comment)
    end
    it "get follows" do
      expect(@user.following.size).to eql(1)
      expect(@user.following.last).to eql(@idea)
      expect(@idea.followers.last).to eql(@user)
    end
    it "get posts" do
      expect(@user.posts.size).to eql(1)
      expect(@user.posts.last).to eql(@post)
      expect(@user_two.posts.size).to eql(1)
      expect(@user_two.posts.last).to eql(@post_two)
    end
    it "get post comments" do
      expect(@user.post_comments.size).to eql(1)
      expect(@user.post_comments.last).to eql(@post_comment_two)
      expect(@user_two.post_comments.size).to eql(1)
      expect(@user_two.post_comments.last).to eql(@post_comment)
    end
    it "get comment sends" do
      expect(@user.comment_sends.size).to eql(1)
      expect(@user.comment_sends.last).to eql(@user_comment)
      expect(@user.comment_receives.size).to eql(0)
    end
    it "get comment receives" do
      expect(@user_two.comment_receives.size).to eql(1)
      expect(@user_two.comment_receives.last).to eql(@user_comment)
      expect(@user_two.comment_sends.size).to eql(0)
    end
    it "get message sends" do
      expect(@user.message_sends.size).to eql(1)
      expect(@user.message_sends.last).to eql(@message)
      expect(@user.message_receives.size).to eql(0)
    end
    it "get message receives" do
      expect(@user_two.message_receives.size).to eql(1)
      expect(@user_two.message_receives.last).to eql(@message)
      expect(@user_two.message_sends.size).to eql(0)
    end
  end
end
