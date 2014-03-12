require 'spec_helper'

describe CategoriesController do

  before(:each) do
    request.env['HTTP_REFERER'] = '/'
  end

  context "Actions" do
    before do
      @user = FactoryGirl.create(:user)
      sign_in @user

      @idea = FactoryGirl.create(:idea)
      @idea.users << @user
      @idea.save!
      @forum = FactoryGirl.create(:forum, idea_id: @idea.id)
    end
    context "#GET" do
      it "get one forum" do
        post :create, category: FactoryGirl.attributes_for(:category, forum_id: @forum.id)
        get :show, id: Category.last.id
        expect(response).to render_template(:show)
      end
    end
    context "#POST" do
      it "Succefuly" do
        expect{
          post :create, category: FactoryGirl.attributes_for(:category, forum_id: @forum.id)
        }.to change(Category,:count).by(1)
      end
      it "Fail" do
        expect {
          post :create, category: FactoryGirl.attributes_for(:category, :title => '', forum_id: @forum.id)
        }.to raise_error

        pending { expect(response).to render_template(:new) }
      end
    end
    context "#PUT" do
      it "Succefuly" do
        post :create, category: FactoryGirl.attributes_for(:category, forum_id: @forum.id)
        category = Category.last
        put :update, id: category.id, category: FactoryGirl.attributes_for(:category, :title => 'changed', forum_id: @forum.id)
        category.reload
        expect(category.title).to eql('changed')
      end
      it "Fail" do
        post :create, category: FactoryGirl.attributes_for(:category, forum_id: @forum.id)
        put :update, id: Category.last.id, category: FactoryGirl.attributes_for(:category, title: '', forum_id: @forum.id)
        expect(response).to render_template(:edit)
      end
    end
    context "#DELETE" do
      it "Succefuly" do
        post :create, category: FactoryGirl.attributes_for(:category, forum_id: @forum.id)
        category = Category.last
        expect{
          delete :destroy, id: category.id
        }.to change(Category,:count).by(-1)
      end
    end
    context "#ASSHOLE" do
      it "#MANAGE one forum that not belongs to me" do
        user = FactoryGirl.create(:user)
        forum = FactoryGirl.create(:forum)
        idea_admin = FactoryGirl.create(:idea_admin, user: user, idea: forum.idea)
        category = FactoryGirl.create(:category, forum: forum)

        expect{
          delete :destroy, id: category.id
        }.to change(Category,:count).by(0)
      end
      it "#MANAGE one idea that not belongs to me" do
        idea = FactoryGirl.create(:idea)
        forum = FactoryGirl.create(:forum, idea_id: idea.id)
        post :create, category: FactoryGirl.attributes_for(:category, forum_id: forum.id)
        expect(response).to redirect_to(action: :index)
      end
    end
  end
end
