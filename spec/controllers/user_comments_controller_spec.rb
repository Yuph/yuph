require 'spec_helper'

describe UserCommentsController do
  context "Actions" do
    before do
      @user = FactoryGirl.create(:user)
      @user_two = FactoryGirl.create(:user, email: "teste@teste.com")
      session[:user] = @user.id
    end
    context "#GET" do
      it "Render 'new' template" do
        get :new
        expect(response).to render_template(:new)
      end
      it "get one ..." do
        post :create, user_comment: FactoryGirl.attributes_for(:user_comment, comment_receiver_id: @user_two.id)
        get :show, id: UserComment.last.id
        expect(response).to render_template(:show)
      end
    end
    context "#POST" do
      it "Succefully" do
        expect{
          post :create, user_comment: FactoryGirl.attributes_for(:user_comment, comment_receiver_id: @user_two.id)
        }.to change(UserComment,:count).by(1)
      end
      it "Fail" do
        post :create, user_comment: FactoryGirl.attributes_for(:user_comment, title: "", comment_receiver_id: @user_two.id)
        expect(response).to render_template(:new)
      end
    end
    context "#PUT" do
      it "Succefully" do
        post :create, user_comment: FactoryGirl.attributes_for(:user_comment, comment_receiver_id: @user_two.id)
        user_comment = UserComment.last
        put :update, id: user_comment.id, user_comment: FactoryGirl.attributes_for(:user_comment, comment_receiver_id: @user_two.id, title: "changed")
        user_comment.reload
        expect(user_comment.title).to eql("changed")
      end
      it "Fail" do
        post :create, user_comment: FactoryGirl.attributes_for(:user_comment, comment_receiver_id: @user_two.id)
        user_comment = UserComment.last
        put :update, id: user_comment.id, user_comment: FactoryGirl.attributes_for(:user_comment, comment_receiver_id: @user_two.id, title: "")
        expect(response).to render_template(:edit)
      end
    end
    context "#DELETE" do
      it "Succefully" do
        post :create, user_comment: FactoryGirl.attributes_for(:user_comment, comment_receiver_id: @user_two.id)
        user_comment = UserComment.last
        expect{
          delete :destroy, id: user_comment.id
        }.to change(UserComment,:count).by(-1)
      end
    end
    context "ASSHOLE" do
      it "#TRY access things that not belongs to me" do
        post :create, user_comment: FactoryGirl.attributes_for(:user_comment, comment_receiver_id: @user_two.id)
        user_comment = UserComment.last
        user = FactoryGirl.create(:user)
        session[:user] = user.id
        expect{
          delete :destroy, id: user_comment.id
        }.to change(UserComment,:count).by(0)
      end
    end
  end
end
