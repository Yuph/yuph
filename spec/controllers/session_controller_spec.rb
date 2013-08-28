require 'spec_helper'

describe SessionController do
  context "#GET" do
    it "index page" do
      user = FactoryGirl.create(:user)
      get :index
      expect(response.code).to eql("200")
    end
    it "require log in" do
      user = FactoryGirl.create(:user)
      get :login, user: FactoryGirl.attributes_for(:user)
      expect(response).to redirect_to(user)
      expect(flash[:notice]).to be_nil
      expect(session[:user]).to eql(user.id)
    end
    context "action when logged" do
      before :each do
        user = FactoryGirl.create(:user)
        get :login, user: FactoryGirl.attributes_for(:user)
        expect(response).to redirect_to(user)
        expect(flash[:notice]).to be_nil
      end
      it "logged" do
        get :logout
        expect(response.code).to eql("200")
      end
      it "logout" do
        get :logout
        expect(response.code).to eql("200")
        get :logout
        expect(response.code).to eql("302")
      end
    end
  end
end
