require 'spec_helper'

describe ForumController do
	context "Actions" do
    	before do
      		@user = FactoryGirl.create(:user)
      		session[:user] = @user.id
      		@idea = FactoryGirl.create(:idea)
    	end
    	context "#GET" do
    		it "Render 'new' Template" do
    			get :new
    			expect(response).to render_template(:new)
    		end
    	end
    	context "#POST" do
    		it "Succefuly" do
		    	expect{
		      		@idea.users << @user
		        	@idea.save!
		        	post :create, forum: FactoryGirl.attributes_for(:forum, idea_id: @idea.id)
		    	}.to change(Forum,:count).by(1)
    		end
	    end
	    context "#PUT" do
	    	it "Succefuly" do
		      @idea.users << @user
		      @idea.save!
		      post :create, forum: FactoryGirl.attributes_for(:forum, idea_id: @idea.id)
		      forum = Forum.last
		      put :update, id: forum.id, forum: FactoryGirl.attributes_for(:forum, idea_id: @idea.id, password: "12345")
		      forum.reload
		      expect(forum.password).to eql("12345")
		    end
	    end
	    context "#DELETE" do
		    it "Succefuly" do
		      @idea.users << @user
		      @idea.save!
		      post :create, forum: FactoryGirl.attributes_for(:forum, idea_id: @idea.id)
		      forum = Forum.last
		      expect{
		        delete :destroy, id: forum.id
		      }.to change(Forum,:count).by(-1)
		    end
		end
		context "#ASSHOLE" do
		    it "#MANAGE one forum that not belongs to me" do
		      @idea.users << @user
		      @idea.save!
		      post :create, forum: FactoryGirl.attributes_for(:forum, idea_id: @idea.id)
		      forum = Forum.last
		      user = FactoryGirl.create(:user)
		      session[:user] = user.id
		      expect{
		        delete :destroy, id: forum.id
		      }.to change(Forum,:count).by(0)
		    end
		end
  	end
end
