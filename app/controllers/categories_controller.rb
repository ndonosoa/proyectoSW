class CategoriesController < ApplicationController
  before_action :set_category, only: [:destroy, :show, :update]
  def index
    @category = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to :action => "index"
    else
      render :new
    end
  end

  def show
  end

  def update
  end

  def destroy
    @category.destroy
    redirect_to :action => "index"
  end
  private
   def set_category
     @category = Category.find(params[:id])
   end
   def category_params
      params.require(:category).permit(:category_name)
   end
end
