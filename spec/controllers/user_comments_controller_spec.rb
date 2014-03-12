require 'spec_helper'

describe UserCommentsController do
  before(:each) do
    request.env["HTTP_REFERER"] = "http://test.host/"
  end

  context "Actions" do
    before do
      @user = FactoryGirl.create(:user)
      @user_two = FactoryGirl.create(:user)
      @sample_comment = FactoryGirl.create(:user_comment)
      sign_in @user
    end

    it { should_authorize an_instance_of(UserComment), :create, :via => :post, user_comment: FactoryGirl.attributes_for(:user_comment, comment_receiver_id: @user_two.id) }
    it { should_authorize an_instance_of(UserComment), :destroy, :via => :delete, :id => @sample_comment.id }

    context "#POST" do
      it "Succefully" do
        expect{
          post :create, user_comment: FactoryGirl.attributes_for(:user_comment, comment_receiver_id: @user_two.id)
        }.to change(UserComment,:count).by(1)
      end
      it "Fail" do
        post :create, user_comment: FactoryGirl.attributes_for(:user_comment, message: nil, comment_receiver_id: nil)
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
        user = FactoryGirl.create(:user)
        user_comment = FactoryGirl.create(:user_comment, comment_sender: user)

        expect{
          delete :destroy, id: user_comment.id
        }.to change(UserComment,:count).by(0)
      end
    end
  end
end