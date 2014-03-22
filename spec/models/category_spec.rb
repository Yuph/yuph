require 'spec_helper'

describe Category do
  context "validate presence of" do

    # Description ins't mandatory anymore
    pending "description" do
      category = Category.create
      expect(category).to have(1).error_on(:description)
    end

    it "forum" do
      category = Category.create
      expect(category).to have(1).error_on(:forum)
    end
  end
end
