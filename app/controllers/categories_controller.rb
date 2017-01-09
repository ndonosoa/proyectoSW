class CategoriesController < ApplicationController
  before_action :set_category, only: [:destroy, :show, :edit]
  def index
    @category = Category.where("category_state = 1")
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.category_state = 1
    if @category.save
      redirect_to :action => "index"
    else
      render :new
    end
  end

  def show
  end

  def edit
    if @category.update(:category_state => '0')
      redirect_to :action => "index"
    else
      render :new
    end
  end

  def destroy
  end
  private
   def set_category
     @category = Category.find(params[:id])
   end
   def category_params
      params.require(:category).permit(:category_name)
   end
end
