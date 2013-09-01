require 'spec_helper'

describe UsersController do
  context "#POST" do
    it "Succefuly" do
      expect{
        post :create, user: FactoryGirl.attributes_for(:user)
      }.to change(User,:count).by(1)
    end
    it "Fail" do
      post :create, user: FactoryGirl.attributes_for(:user, nick: "")
      expect(response).to render_template(:new)
    end
  end
  context "Actions" do
    before do
      @user = FactoryGirl.create(:user)
      session[:user] = @user.id
    end
    context "#GET" do
      it "Render 'new' template" do
        get :new
        expect(response).to render_template(:new)
      end
      it "get one user" do
        post :create, user: FactoryGirl.attributes_for(:user)
        get :show, id: User.last
        expect(response).to render_template(:show)
      end
    end
    context "#PUT" do
      it "Succefully" do
        expect(@user.about).to be_nil
        put :update, id: @user.id, user: FactoryGirl.attributes_for(:full_user)
        user = @user.reload
        expect(user.about).to_not be nil
      end
      it "Fail" do
        expect(@user.about).to be_nil
        put :update, id: @user.id, user: FactoryGirl.attributes_for(:full_user, nick:"")
        expect(response).to render_template(:edit)
      end
    end
    context "#DELETE" do
      it "Succefully" do
        expect{
          delete :destroy, id: @user.id
        }.to change(User,:count).by(-1)
      end
    end
    context "ASSHOLE" do
      it "#TRY access things that not belongs to me" do
        user = FactoryGirl.create(:user)
        session[:user] = user.id
        expect{
          delete :destroy, id: @user.id
        }.to change(User,:count).by(0)
      end
    end
  end
end

