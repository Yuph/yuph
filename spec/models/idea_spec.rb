require 'spec_helper'

describe Idea do
  context "validate presence of" do
    it "name" do
      idea = Idea.create
      expect(idea).to have(1).error_on(:name)
    end
    it "mini_description" do
      idea = Idea.create
      expect(idea).to have(1).error_on(:mini_description)
    end
    it "description" do
      idea = Idea.create
      expect(idea).to have(1).error_on(:description)
    end
    it "image" do
      idea = Idea.create
      expect(idea).to have(1).error_on(:image)
    end
  end
end
