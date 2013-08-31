require 'spec_helper'

describe IdeaCommentsController do
	context "Actions" do
    	before do
      		@user = FactoryGirl.create(:user)
      		session[:user] = @user.id
      		@idea = FactoryGirl.create(:idea)
    	end
    	context "#GET" do
    		it "Render 'new' template" do
    			get :new
    			expect(response).to render_template(:new)
    		end
    		it "Show one idea comment" do
    			post :create, idea_comment: FactoryGirl.attributes_for(:idea_comment, idea_id: @idea.id)
    			idea_comment = IdeaComment.last
    			get :show, id:idea_comment.id
    		end
    	end
    	context "#POST" do
    		it "Succefully" do
    			expect{
	        		post :create, idea_comment: FactoryGirl.attributes_for(:idea_comment, idea_id: @idea.id)
	      		}.to change(IdeaComment,:count).by(1)
    		end
    		it "Fail" do
    			post :create, idea_comment: FactoryGirl.attributes_for(:idea_comment, message: "", idea_id: @idea.id)
    			expect(response).to render_template(:new)
    		end
    	end
    	context "#PUT" do
    		it "Succefully" do
    		  post :create, idea_comment: FactoryGirl.attributes_for(:idea_comment, idea_id: @idea.id)
		      idea_comment = IdeaComment.last
		      put :update, id: idea_comment.id, idea_comment: FactoryGirl.attributes_for(:idea_comment, idea_id: @idea.id, title: "changed")
		      idea_comment.reload
		      expect(idea_comment.title).to eql("changed")
    		end
    		it "Fail" do
    		  post :create, idea_comment: FactoryGirl.attributes_for(:idea_comment, idea_id: @idea.id)
		      idea_comment = IdeaComment.last
		      put :update, id: idea_comment.id, idea_comment: FactoryGirl.attributes_for(:idea_comment, message: "", idea_id: @idea.id, title: "changed")
		      expect(response).to render_template(:edit)
    		end
    	end
    	context "#DELETE" do
    		it "Succefully" do
    			post :create, idea_comment: FactoryGirl.attributes_for(:idea_comment, idea_id: @idea.id)
	      		idea_comment = IdeaComment.last
	      		expect{
	        		delete :destroy, id: idea_comment.id
	      		}.to change(IdeaComment,:count).by(-1)
    		end
    	end
    	context "ASSHOLE" do
    		it "#MANAGE one idea_comment that not belongs to me" do
    		  post :create, idea_comment: FactoryGirl.attributes_for(:idea_comment, idea_id: @idea.id)
		      idea_comment = IdeaComment.last
		      user = FactoryGirl.create(:user)
		      session[:user] = user.id
		      expect{
		        delete :destroy, id: idea_comment.id
		      }.to change(IdeaComment,:count).by(0)
    		end
    	end
  	end
end
