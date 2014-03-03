require 'spec_helper'

describe UserComment do
  context "validation presence of" do
    it "message" do
      user_comment = UserComment.create
      expect(user_comment).to have(1).error_on(:message)
    end
    it "receiver" do
      user_comment = UserComment.create
      expect(user_comment).to have(1).error_on(:comment_receiver)
    end
    it "sender" do
      user_comment = UserComment.create
      expect(user_comment).to have(1).error_on(:comment_sender)
    end
  end
  context "actions" do
    it "succefuly create" do
      sender = FactoryGirl.create(:user)
      receiver = FactoryGirl.create(:user)
      user_comment = FactoryGirl.create(:user_comment, comment_receiver_id: receiver.id, comment_sender_id: sender.id)
      expect(user_comment).to have(:no).error
    end
    it "fail create" do
      user_comment = UserComment.create(message: "como tu fez isso?", comment_receiver_id: 345345, comment_sender_id: 75677)
      expect(user_comment).to have(2).error
    end
    it "get my total comments" do
      sender = FactoryGirl.create(:user)
      sender_two = FactoryGirl.create(:user)
      receiver = FactoryGirl.create(:user)
      UserComment.create(message: "como tu fez isso?", comment_receiver_id: receiver.id, comment_sender_id: sender.id)
      UserComment.create(message: "show de bola", comment_receiver_id: receiver.id, comment_sender_id: sender_two.id)
      expect(receiver.comment_receives.size).to eql(2)
      expect(sender.comment_sends.size).to eql(1)
    end
  end
end
