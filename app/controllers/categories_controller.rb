class CategoriesController < ApplicationController
  before_filter :set_category, :only => [:edit, :update, :destroy]
  before_filter :set_forum, :only => [:create, :update]

  def index
  end

  def create
    set_session_user
    @category = @forum.categories.build(category_params)
    if @category.save!
      redirect_to :back, notice: "Succefully created !"
    else
      redirect_to :back, notice: "Succefully created !"
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def update
    if  @category.update_attributes(category_params)
      redirect_to @category, notice: "Updated"
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to :back
  end

  def set_category
    set_session_user
    @category = Category.find(params[:id])
    if !@category.can_managed_by(@user)
      redirect_to :back, notice: "fails created !"
    end
  end

  def set_forum
    @forum = Forum.find(params[:category][:forum_id])
  end

  def category_params
    params.require(:category).permit(:title, :forum_id)
  end
end

