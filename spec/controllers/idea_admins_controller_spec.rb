require 'spec_helper'

describe IdeaAdminsController do
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
    			post :create, idea_admin: FactoryGirl.attributes_for(:idea_admin, idea_id: @idea.id)
    			get :show, id: IdeaAdmin.last.id
    		end
    	end
    	context "#POST" do
    		it "Succefully" do
    			expect{
	        		post :create, idea_admin: FactoryGirl.attributes_for(:idea_admin, idea_id: @idea.id)
	      		}.to change(IdeaAdmin,:count).by(1)
    		end
    		it "Fail" do
    			post :create, idea_admin: FactoryGirl.attributes_for(:idea_admin, idea_id: "")
    			expect(response).to render_template(:new)
    		end
    	end
    	context "#PUT" do
    		it "Succefully" do
    		  post :create, idea_admin: FactoryGirl.attributes_for(:idea_admin, idea_id: @idea.id)
		      idea_admin = IdeaAdmin.last
          idea = FactoryGirl.create(:idea)
		      put :update, id: idea_admin.id, idea_admin: FactoryGirl.attributes_for(:idea_admin, idea_id: idea.id)
		      idea_admin.reload
		      expect(idea_admin.idea).to eql(idea)
          expect(idea_admin.idea).to_not eql(@idea)
    		end
    		it "Fail" do
    		  post :create, idea_admin: FactoryGirl.attributes_for(:idea_admin, idea_id: @idea.id)
		      idea_admin = IdeaAdmin.last
		      put :update, id: idea_admin.id, idea_admin: FactoryGirl.attributes_for(:idea_admin, idea_id: "")
		      expect(response).to render_template(:edit)
    		end
    	end
    	context "#DELETE" do
    		it "Succefully" do
    			post :create, idea_admin: FactoryGirl.attributes_for(:idea_admin, idea_id: @idea.id)
	      		idea_admin = IdeaAdmin.last
	      		expect{
	        		delete :destroy, id: idea_admin.id
	      		}.to change(IdeaAdmin,:count).by(-1)
    		end
    	end
    	context "ASSHOLE" do
    		it "#MANAGE one idea_admin that not belongs to me" do
    		  post :create, idea_admin: FactoryGirl.attributes_for(:idea_admin, idea_id: @idea.id)
		      idea_admin = IdeaAdmin.last
		      user = FactoryGirl.create(:user)
		      session[:user] = user.id
		      expect{
		        delete :destroy, id: idea_admin.id
		      }.to change(IdeaAdmin,:count).by(0)
    		end
    	end
  	end
end

