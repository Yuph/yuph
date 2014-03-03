require 'spec_helper'

describe UsersController do
  context "#POST" do
    it "Succefuly" do
      pending "new user style"
      # expect{
      #   post :create, user: FactoryGirl.attributes_for(:full_user)
      # }.to change(User,:count).by(1)
    end
    it "Fail" do
      # post :create, user: FactoryGirl.attributes_for(:user, email: "")
      # expect(response).to render_template(:new)
    end
  end
  context "Actions" do
    before do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end
    context "#GET" do
      it "Render 'new' template" do
        pending 'new login style'
        # get :new
        # expect(response).to render_template(:new)
      end
      it "get one user" do
        pending "new style user"
        # post :create, user: FactoryGirl.attributes_for(:user)
        # get :show, id: User.last
        # expect(response).to render_template(:show)
      end
    end
    context "#PUT" do
      it "Succefully" do
        pending "new user style"
        # expect(@user.about).to be_nil
        # put :update, id: @user.id, user: FactoryGirl.attributes_for(:full_user)
        # user = @user.reload
        # expect(user.about).to_not be nil
      end
      it "Fail" do
        # expect(@user.about).to be_nil
        # put :update, id: @user.id, user: FactoryGirl.attributes_for(:full_user, email:"")
        # expect(response).to render_template(:edit)
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

        sign_out @user
        sign_in user

        expect{
          delete :destroy, id: @user.id
        }.to change(User,:count).by(0)
      end
    end
  end
end

