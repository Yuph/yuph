require 'spec_helper'

describe PostCommentsController do
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
      @post_comment = FactoryGirl.create(:post, category_id: @category.id, user_id: @post_creator.id)
    end
    context "#GET" do
      it "Render 'new' Template" do
        get :new
        expect(response).to render_template(:new)
      end
      it "get one forum" do
        post :create, post_comment: FactoryGirl.attributes_for(:post_comment, post_id: @post_comment.id)
        get :show, id: PostComment.last.id
        expect(response).to render_template(:show)
      end
    end
    context "#POST" do
      it "Succefuly" do
        expect{
          post :create, post_comment: FactoryGirl.attributes_for(:post_comment, post_id: @post_comment.id)
        }.to change(PostComment,:count).by(1)
      end
      it "Fail" do
        post :create, post_comment: FactoryGirl.attributes_for(:post, title: "", category_id: @category.id)
        expect(response).to render_template(:new)
      end
    end
    context "#PUT" do
      it "Succefuly" do
        post :create, post_comment: FactoryGirl.attributes_for(:post_comment, post_id: @post_comment.id)
        post_comment = PostComment.last
        put :update, id: post_comment.id, post_comment: FactoryGirl.attributes_for(:post_comment, title: "changed", post_id: @post_comment.id)
        post_comment.reload
        expect(post_comment.title).to eql("changed")
      end
      it "Fail" do
        post :create, post_comment: FactoryGirl.attributes_for(:post_comment, post_id: @post_comment.id)
        put :update, id: PostComment.last.id, post_comment: FactoryGirl.attributes_for(:post_comment, title: "", post_id: @post_comment.id)
        expect(response).to render_template(:edit)
      end
    end
    context "#DELETE" do
      it "Succefuly with creator" do
        post :create, post_comment: FactoryGirl.attributes_for(:post_comment, post_id: @post_comment.id)
        post_comment = PostComment.last
        expect{
          delete :destroy, id: post_comment.id
        }.to change(PostComment,:count).by(-1)
      end
      it "Succefuly with admin" do
        session[:user] = @post_creator.id
        post :create, post_comment: FactoryGirl.attributes_for(:post_comment, post_id: @post_comment.id)
        session[:user] = @user.id
        post_comment = PostComment.last
        expect{
          delete :destroy, id: post_comment.id
        }.to change(PostComment,:count).by(-1)
      end
    end
    context "#ASSHOLE" do
      it "#MANAGE one forum that not belongs to me" do
        post :create, post_comment: FactoryGirl.attributes_for(:post_comment, post_id: @post_comment.id)
        post_comment = PostComment.last
        user = FactoryGirl.create(:user)
        session[:user] = user.id
        expect{
          delete :destroy, id: post_comment.id
        }.to change(PostComment,:count).by(0)
      end
    end
  end
end
