class ProductsController < ApplicationController
  def index
    @product = Product.all
  end
  def show
    @productfiltro = Product.where(product_name: params[:product_name])
    redirect_to :action => "new"
  end

  def update
  end

  def destroy
  end

  def create
  end

  def new
    @product = Product.new
  end
end
