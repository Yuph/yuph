require 'spec_helper'

describe Forum do
  context "validate presence of" do
    it "idea" do
      forum = Forum.create
      expect(forum).to have(1).error_on(:idea)
    end
  end
  context "actions" do
    it "try save with false idea" do
      forum = Forum.create(idea_id: 1223)
      expect(forum).to have(1).error_on(:idea)
    end
  end
end
