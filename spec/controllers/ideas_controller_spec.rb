require 'spec_helper'

describe IdeasController do
  context "Actions" do
    before do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end
    context "#GET" do
      it "Render 'index' template" do
        get :index
        expect(response).to render_template(:index)
      end
      it "Render 'new' template" do
        get :new
        expect(response).to render_template(:new)
      end
      it "get one idea" do
        post :create, idea: FactoryGirl.attributes_for(:idea)
        get :show, id: Idea.last.id
        expect(response).to render_template(:show)
      end
    end
    context "#POST" do
      it "Succefully" do
        expect{
          post :create, idea: FactoryGirl.attributes_for(:idea)
        }.to change(Idea,:count).by(1)
      end
      it "Fail" do
        post :create, idea: FactoryGirl.attributes_for(:idea, name: "")
        expect(response).to render_template(:new)
      end
    end
    context "#PUT" do
      it "Succefully" do
        post :create, idea: FactoryGirl.attributes_for(:idea)
        idea = Idea.last
        put :update, id: idea.id, idea: FactoryGirl.attributes_for(:idea, name: "changed")
        idea.reload
        expect(idea.name).to eql("changed")
      end
      it "Fail" do
        post :create, idea: FactoryGirl.attributes_for(:idea)
        idea = Idea.last
        put :update, id: idea.id, idea: FactoryGirl.attributes_for(:idea, name: "")
        expect(response).to render_template(:edit)
      end
    end
    context "#DELETE" do
      it "Succefully" do
        post :create, idea: FactoryGirl.attributes_for(:idea)
        idea = Idea.last
        expect{
          delete :destroy, id: idea.id
        }.to change(Idea,:count).by(-1)
      end
    end
    context "ASSHOLE" do
      it "#TRY access things that not belongs to me" do
        post :create, idea: FactoryGirl.attributes_for(:idea)
        idea = Idea.last
        user = FactoryGirl.create(:user)

        sign_out @user
        sign_in user

        expect{
          delete :destroy, id: idea.id
        }.to change(Idea,:count).by(0)
      end
    end
  end
end
