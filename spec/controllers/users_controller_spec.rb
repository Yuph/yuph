require 'spec_helper'

describe UsersController do
  context "#GET" do
    it "not logged" do
      user = FactoryGirl.create(:user)
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
  context "Not logged" do
    it "#POST" do
      expect{
        post :create, user: FactoryGirl.attributes_for(:user)
      }.to change(User,:count).by(1)
    end
  end
  context "Logged" do
    before do
      @user = FactoryGirl.create(:user)
      session[:user] = @user.id
    end
    it "#PUT" do
      expect(@user.about).to be_nil
      put :update, id: @user.id, user: FactoryGirl.attributes_for(:full_user)
      user = @user.reload
      expect(user.about).to_not be nil
    end
    it "#DELETE" do
      expect{
        delete :destroy, id: @user.id
      }.to change(User,:count).by(-1)
    end
  end
end
