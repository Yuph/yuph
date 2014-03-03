require 'spec_helper'

describe MessagesController do
  context "Actions" do
      before do
        @user = FactoryGirl.create(:user)
        @user_two = FactoryGirl.create(:user, email: "teste@teste.com")
        sign_in @user
      end

      context "#GET" do
        it "New" do
          get :new
          expect(response).to render_template(:new)
        end
      end
      context "#POST" do
        it "Fail" do
          expect{
              post :create, message: FactoryGirl.attributes_for(:message, title: "")
            }.to change(Message,:count).by(0)
        end
        it "Succefuly" do
            expect{
              post :create, message: FactoryGirl.attributes_for(:message, message_receiver_id: @user_two.id)
            }.to change(Message,:count).by(1)
        end
      end
      context "#PUT" do
        it "Succefuly" do
            post :create, message: FactoryGirl.attributes_for(:message, message_receiver_id: @user_two.id)
            message = Message.last
            put :update, id: message.id, message: FactoryGirl.attributes_for(:message, message_receiver_id: @user_two.id, title: "changed")
            message.reload
            expect(message.title).to eql("changed")
        end
        it "Fail" do
            post :create, message: FactoryGirl.attributes_for(:message, title: "Como estás ?", message_receiver_id: @user_two.id)
            message = Message.last
                put :update, id: message.id, message: FactoryGirl.attributes_for(:message, title: "")
            message.reload
            expect(message.title).to eql("Como estás ?")
            expect(response).to render_template(:edit)
        end
      end
      context "#DELETE" do
        it "Succefuly" do
            post :create, message: FactoryGirl.attributes_for(:message, message_receiver_id: @user_two.id)
            message = Message.last
            expect{
              delete :destroy, id: message.id
            }.to change(Message,:count).by(-1)
        end
      end
      context "#ASSHOLE" do
        let (:message) { Message.last }
          let (:user) { FactoryGirl.create(:user) }

          it "#MANAGE one idea that not belongs to me" do
            post :create, message: FactoryGirl.attributes_for(:message, message_receiver_id: @user_two.id)

            sign_out @user
            sign_in user

            expect{
              delete :destroy, id: message.id
            }.to change(Message,:count).by(0)
          end
      end
    end
end
