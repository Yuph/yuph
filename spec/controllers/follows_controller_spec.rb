require 'spec_helper'

describe FollowsController do
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
    		it "Show admin_ideas" do
    			post :create, follow: FactoryGirl.attributes_for(:follow, idea_id: @idea.id)
    			get :show, id: Follow.last.id
    		end
    	end
    	context "#POST" do
    		it "Succefully" do
    			expect{
	        		post :create, follow: FactoryGirl.attributes_for(:follow, idea_id: @idea.id)
	      		}.to change(Follow,:count).by(1)
    		end
    		it "Fail" do
    			post :create, follow: FactoryGirl.attributes_for(:follow, idea_id: "")
    			expect(response).to render_template(:new)
    		end
    	end
    	context "#PUT" do
    		it "Succefully" do
    		  post :create, follow: FactoryGirl.attributes_for(:follow, idea_id: @idea.id)
		      follow = Follow.last
          idea = FactoryGirl.create(:idea)
		      put :update, id: follow.id, follow: FactoryGirl.attributes_for(:follow, idea_id: idea.id)
		      follow.reload
		      expect(follow.idea).to eql(idea)
          expect(follow.idea).to_not eql(@idea)
    		end
    		it "Fail" do
    		  post :create, follow: FactoryGirl.attributes_for(:follow, idea_id: @idea.id)
		      follow = Follow.last
		      put :update, id: follow.id, follow: FactoryGirl.attributes_for(:follow, idea_id: "")
		      expect(response).to render_template(:edit)
    		end
    	end
    	context "#DELETE" do
    		it "Succefully" do
    			post :create, follow: FactoryGirl.attributes_for(:follow, idea_id: @idea.id)
	      		follow = Follow.last
	      		expect{
	        		delete :destroy, id: follow.id
	      		}.to change(Follow,:count).by(-1)
    		end
    	end
    	context "ASSHOLE" do
    		it "#MANAGE one follow that not belongs to me" do
    		  post :create, follow: FactoryGirl.attributes_for(:follow, idea_id: @idea.id)
		      follow = Follow.last
		      user = FactoryGirl.create(:user)
		      session[:user] = user.id
		      expect{
		        delete :destroy, id: follow.id
		      }.to change(Follow,:count).by(0)
    		end
    	end
  	end
end

