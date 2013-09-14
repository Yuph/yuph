require 'spec_helper'

describe UserCommentsController do
  before(:each) do
      request.env["HTTP_REFERER"] = "http://test.com"
    end
  context "Actions" do
    before do
      @user = FactoryGirl.create(:user)
      @user_two = FactoryGirl.create(:user, email: "teste@teste.com")
      session[:user] = @user.id
    end
    context "#POST" do
      it "Succefully" do
        expect{
          post :create, user_comment: FactoryGirl.attributes_for(:user_comment, comment_receiver_id: @user_two.id)
        }.to change(UserComment,:count).by(1)
      end
      it "Fail" do
        post :create, user_comment: FactoryGirl.attributes_for(:user_comment, title: "", comment_receiver_id: @user_two.id)
        expect(response).to redirect_to :back
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
