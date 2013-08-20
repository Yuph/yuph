require 'spec_helper'

describe User do
  context "validate presence of" do
    it "nickname" do
      user = User.create
      expect(user).to have(1).error_on(:nick)
    end
    it "password" do
      user = User.create
      expect(user).to have(2).error_on(:password)
    end
    it "email" do
      user = User.create
      expect(user).to have(2).error_on(:email)
    end
  end
  context "validate length of" do
    it "password with 5 characters" do
      user = User.create(password: "12345")
      expect(user).to have(1).error_on(:password)
    end
    it "password between 6 and 20" do
      user = User.create(password: "123456")
      expect(user).to have(0).error_on(:password)
    end
    it "password more than 20" do
      user = User.create(password: "123457890123456789012")
      expect(user).to have(1).error_on(:password)
    end
  end
  context "validate email" do
    it "correct" do
      user = User.create(email: "victor@victorantoniazzi.com.br")
      expect(user).to have(0).error_on(:email)
    end
    it "incorrect" do
      user = User.create(email: "victor.com.br")
      expect(user).to have(1).error_on(:email)
    end
  end
  context "hash password" do
    it "getting my hash" do
      User.create(nick: "victor-antoniazzi", email: "vgsantoniazzi@gmail.com", password: "test123")
      user = User.last
      expect(user.password).to eql("3b3de67e92efc05a96b7b40b450bcd179040c4f9")
    end
  end
  context "login" do
    before do
      User.create(nick: "victor-antoniazzi", email: "vgsantoniazzi@gmail.com", password: "test123")
    end
    it "pass" do
      user = User.login("vgsantoniazzi@gmail.com", "test123")
      expect(user.email).to eql("vgsantoniazzi@gmail.com")
    end
    it "try invalid" do
      user = User.login("vgsantoniazzi@gmail.com", "test1234")
      expect(user).to be nil
    end
  end
end
