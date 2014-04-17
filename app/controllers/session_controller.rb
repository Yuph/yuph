class SessionController < ApplicationController
  skip_before_filter :authenticate_user!, :all

  def index
    @yuph = Idea.first
    @ideas = Idea.last(4)
  end
end
