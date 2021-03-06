require 'spec_helper'

describe Message do
  context "validate presense of" do
    it "title" do
      message = Message.create
      expect(message).to have(1).error_on(:title)
    end
    it "message" do
      message = Message.create
      expect(message).to have(1).error_on(:body)
    end
    it "message_sender" do
      message = Message.create
      expect(message).to have(1).error_on(:message_sender)
    end
    it "message_receiver" do
      message = Message.create
      expect(message).to have(1).error_on(:message_receiver)
    end
  end
  context "actions" do
    it "succefuly create" do
      sender = FactoryGirl.create(:user)
      receiver = FactoryGirl.create(:user)
      message = Message.create(title: "serio xiru?", body: "como tu fez isso?", message_receiver_id: receiver.id, message_sender_id: sender.id)
      expect(message).to have(:no).error
    end
    it "fail create" do
      message = Message.create(title: "serio xiru?", body: "como tu fez isso?", message_receiver_id: 345345, message_sender_id: 75677)
      expect(message).to have(2).error
    end
    it "get my total messages" do
      sender = FactoryGirl.create(:user)
      receiver = FactoryGirl.create(:user)
      FactoryGirl.create(:message, message_receiver_id: receiver.id, message_sender_id: sender.id)
      FactoryGirl.create(:message, message_receiver_id: receiver.id, message_sender_id: sender.id)
      expect(receiver.message_receives.size).to eql(2)
      expect(sender.message_sends.size).to eql(2)
    end
  end
end
