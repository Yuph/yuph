require 'spec_helper'

describe PostComment do
  context "validates presence of" do
    it "title" do
      post_comment = PostComment.create
      expect(post_comment).to have(1).error_on(:title)
    end
    it "message" do
      post_comment = PostComment.create
      expect(post_comment).to have(1).error_on(:message)
    end
    it "post" do
      post_comment = PostComment.create
      expect(post_comment).to have(1).error_on(:post)
    end
    it "user" do
      post_comment = PostComment.create
      expect(post_comment).to have(1).error_on(:user)
    end
  end
end
