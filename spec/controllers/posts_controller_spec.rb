require 'spec_helper'

describe PostsController do
  context "Actions" do
    before do
      @user = FactoryGirl.create(:user)
      session[:user] = @user.id
      @idea = FactoryGirl.create(:idea)
      @idea.users << @user
      @idea.save!
      @forum = FactoryGirl.create(:forum, idea_id: @idea.id)
      @category = FactoryGirl.create(:category, forum_id: @forum.id)
      @post_creator = FactoryGirl.create(:user)
    end
    context "#GET" do
      it "Render 'new' Template" do
        get :new
        expect(response).to render_template(:new)
      end
      it "get one forum" do
        post :create, post: FactoryGirl.attributes_for(:post, category_id: @category.id)
        get :show, id: Post.last.id
        expect(response).to render_template(:show)
      end
    end
    context "#POST" do
      it "Succefuly" do
        expect{
          post :create, post: FactoryGirl.attributes_for(:post, category_id: @category.id)
        }.to change(Post,:count).by(1)
      end
      it "Fail" do
        post :create, post: FactoryGirl.attributes_for(:post, title: "", category_id: @category.id)
        expect(response).to render_template(:new)
      end
    end
    context "#PUT" do
      it "Succefuly" do
        post :create, post: FactoryGirl.attributes_for(:post, category_id: @category.id)
        post = Post.last
        put :update, id: post.id, post: FactoryGirl.attributes_for(:post, title: "changed", category_id: @category.id)
        post.reload
        expect(post.title).to eql("changed")
      end
      it "Fail" do
        post :create, post: FactoryGirl.attributes_for(:post, category_id: @category.id)
        put :update, id: Post.last.id, post: FactoryGirl.attributes_for(:post, title: "", category_id: @category.id)
        expect(response).to render_template(:edit)
      end
    end
    context "#DELETE" do
      it "Succefuly with creator" do
        post :create, post: FactoryGirl.attributes_for(:post, category_id: @category.id)
        post = Post.last
        expect{
          delete :destroy, id: post.id
        }.to change(Post,:count).by(-1)
      end
      it "Succefuly with admin" do
        session[:user] = @post_creator.id
        post :create, post: FactoryGirl.attributes_for(:post, category_id: @category.id)
        session[:user] = @user.id
        post = Post.last
        expect{
          delete :destroy, id: post.id
        }.to change(Post,:count).by(-1)
      end
    end
    context "#ASSHOLE" do
      it "#MANAGE one forum that not belongs to me" do
        post :create, post: FactoryGirl.attributes_for(:post, category_id: @category.id)
        post = Post.last
        user = FactoryGirl.create(:user)
        session[:user] = user.id
        expect{
          delete :destroy, id: post.id
        }.to change(Post,:count).by(0)
      end
    end
  end
end
