require 'spec_helper'

describe FollowsController do
  before(:each) do
      request.env["HTTP_REFERER"] = "http://test.com"
    end
  context "Actions" do
      before do
        @user = FactoryGirl.create(:user)
        sign_in @user

        @idea = FactoryGirl.create(:idea)
      end
      context "#POST" do
        it "Succefully" do
          expect{
              post :create, follow: FactoryGirl.attributes_for(:follow, idea_id: @idea.id)
            }.to change(Follow,:count).by(1)
        end
        it "Fail" do
          post :create, follow: FactoryGirl.attributes_for(:follow, idea_id: "")
          expect(response).to redirect_to(:back)
        end
      end
      context "#DELETE" do
        it "Succefully" do
          post :create, follow: FactoryGirl.attributes_for(:follow, idea_id: @idea.id)
            follow = Follow.last
            expect{
              delete :destroy, id: follow.id
            }.to change(Follow,:count).by(-1)
        end
      end
      context "ASSHOLE" do
        it "#MANAGE one follow that not belongs to me" do
          post :create, follow: FactoryGirl.attributes_for(:follow, idea_id: @idea.id)
          follow = Follow.last
          user = FactoryGirl.create(:user)

          sign_out @user
          sign_in user

          expect{
            delete :destroy, id: follow.id
          }.to change(Follow,:count).by(0)
        end
      end
    end
end

