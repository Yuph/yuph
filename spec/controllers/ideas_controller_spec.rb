require 'spec_helper'

describe IdeasController do
  context "#GET" do
    it "not logged" do
      get :index
      expect(response.code).to eql("302")
    end
    it "logged" do
      user = FactoryGirl.create(:user)
      session[:user] = user.id
      get :index
      expect(response.code).to eql("200")
    end
  end
  context "Logged" do
    before do
      @user = FactoryGirl.create(:user)
      session[:user] = @user.id
    end
    it "#POST" do
      expect{
        post :create, idea: FactoryGirl.attributes_for(:idea)
      }.to change(Idea,:count).by(1)
    end
    it "#PUT" do
      post :create, idea: FactoryGirl.attributes_for(:idea)
      idea = Idea.last
      put :update, id: idea.id, idea: FactoryGirl.attributes_for(:idea, name: "changed")
      idea.reload
      expect(idea.name).to eql("changed")
    end
    it "#DELETE" do
      post :create, idea: FactoryGirl.attributes_for(:idea)
      idea = Idea.last
      session[:user] = 4455
      expect{
        delete :destroy, id: idea.id
      }.to change(Idea,:count).by(-1)
    end
  end
end
