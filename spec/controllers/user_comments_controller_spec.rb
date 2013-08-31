require 'spec_helper'

describe UserCommentsController do
	context "Actions" do
    	before do
      		@user = FactoryGirl.create(:user)
      		@user_two = FactoryGirl.create(:user, email: "teste@teste.com")
      		session[:user] = @user.id
    	end
	    it "#POST" do
	      expect{
	        post :create, user_comment: FactoryGirl.attributes_for(:user_comment, comment_receiver_id: @user_two.id)
	      }.to change(UserComment,:count).by(1)
	    end
	    it "#PUT" do
	      post :create, user_comment: FactoryGirl.attributes_for(:user_comment, comment_receiver_id: @user_two.id)
	      user_comment = UserComment.last
	      put :update, id: user_comment.id, user_comment: FactoryGirl.attributes_for(:user_comment, comment_receiver_id: @user_two.id, title: "changed")
	      user_comment.reload
	      expect(user_comment.title).to eql("changed")
	    end
	    it "#DELETE" do
	      post :create, user_comment: FactoryGirl.attributes_for(:user_comment, comment_receiver_id: @user_two.id)
	      user_comment = UserComment.last
	      expect{
	        delete :destroy, id: user_comment.id
	      }.to change(UserComment,:count).by(-1)
	    end
	    it "#MANAGE one idea that not belongs to me" do
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
