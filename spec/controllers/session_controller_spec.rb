require 'spec_helper'

describe SessionController do
  before do
    user = User.create(nick: "victor-antoniazzi", email: "vgsantoniazzi@gmail.com", password: "53245324")
    idea = Idea.create!(id: 1, name: "Yuph", mini_description: "Brainstorming de ideias", description: "Junte-se a nós", image_file_name: "/assets/yuph.png")
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
      user = FactoryGirl.create(:user)
      get :login, user: FactoryGirl.attributes_for(:user, email: user.email)
      expect(response).to redirect_to(user)
      expect(flash[:notice]).to be_nil
      expect(session[:user]).to eql(user.id)
    end
    it "failure log in" do
      user = FactoryGirl.create(:user)
      get :login, user: FactoryGirl.attributes_for(:user, email: user.email , password: "aeaeae")
      expect(flash[:notice]).to eql("Credentials failure")
    end
    context "action when logged" do
      before :each do
        user = FactoryGirl.create(:user)
        get :login, user: FactoryGirl.attributes_for(:user, email: user.email)
        expect(response).to redirect_to(user)
        expect(flash[:notice]).to be_nil
      end
      it "logged" do
        get :logout
        expect(response.code).to eql("302")
      end
      it "logout" do
        get :logout
        expect(response.code).to eql("302")
        get :logout
        expect(response.code).to eql("302")
      end
    end
  end
end
