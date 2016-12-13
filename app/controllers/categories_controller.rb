class CategoriesController < ApplicationController
  def index
    @category = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_name: params[:category][:category_name])
    if @category.save
      redirect_to :action => "index"
    else
      render :new
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def update
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to :action => "index"
  end
end
