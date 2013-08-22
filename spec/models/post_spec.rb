require 'spec_helper'

describe Post do
  context "validate presence of" do
    it "require title" do
      post = Post.create
      expect(post).to have(1).error_on(:title)
    end
    it "require message" do
      post = Post.create
      expect(post).to have(1).error_on(:message)
    end
    it "require category" do
      post = Post.create
      expect(post).to have(1).error_on(:category)
    end
  end
end
