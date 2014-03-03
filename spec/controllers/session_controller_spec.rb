require 'spec_helper'

describe SessionController do
  before do
    user = FactoryGirl.create(:full_user)
    idea = FactoryGirl.create(:idea)
    idea.users << user
    idea.save!
  end
  context "#GET" do
    it "index page" do
      user = FactoryGirl.create(:user)
      get :index
      expect(response.code).to eql("200")
    end
    it "require log in" do
      pending "new style login"
      # user = FactoryGirl.create(:user)
      # get :login, user: FactoryGirl.attributes_for(:user, email: user.email)
      # expect(response).to redirect_to(user)
      # expect(flash[:notice]).to be_nil
      # expect(current_user.id).to eql(user.id)
    end
    it "failure log in" do
      pending "new style login"
      # user = FactoryGirl.create(:user)
      # get :login, user: FactoryGirl.attributes_for(:user, email: user.email , password: "aeaeae")
      # expect(flash[:notice]).to eql("Credentials failure")
    end
    context "action when logged" do
      pending "new style login"
      # before :each do
      #   user = FactoryGirl.create(:user)
      #   get :login, user: FactoryGirl.attributes_for(:user, email: user.email)
      #   expect(response).to redirect_to(user)
      #   expect(flash[:notice]).to be_nil
      # end
      # it "logged" do
      #   get :logout
      #   expect(response.code).to eql("302")
      # end
      # it "logout" do
      #   get :logout
      #   expect(response.code).to eql("302")
      #   get :logout
      #   expect(response.code).to eql("302")
      # end
    end
  end
end
