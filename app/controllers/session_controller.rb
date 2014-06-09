class SessionController < ApplicationController
  skip_before_filter :authenticate_user!, :index

  def index
    @yuph = Idea.first
    @ideas = Idea.where(promoted: true).last(4)
  end
end
