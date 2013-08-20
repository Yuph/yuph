require 'spec_helper'

describe User do
  context "validate field" do
    it "nickname" do
      user = User.create
      expect(user).to have(1).error_on(:nick)
    end
    it "password" do
      user = User.create
      expect(user).to have(1).error_on(:password)
    end
    it "email" do
      user = User.create
      expect(user).to have(2).error_on(:email)
    end
  end
end
