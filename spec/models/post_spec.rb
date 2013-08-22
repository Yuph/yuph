require 'spec_helper'

describe Post do
  context "validate presence of" do
    it "title" do
      post = Post.create
      expect(post).to have(1).error_on(:title)
    end
    it "message" do
      post = Post.create
      expect(post).to have(1).error_on(:message)
    end
    it "category" do
      post = Post.create
      expect(post).to have(1).error_on(:category)
    end
    it "user" do
      post = Post.create
      expect(post).to have(1).error_on(:user)
    end
  end
end
