class BrandsController < ApplicationController
  def index
    @brand = Brand.all
  end

  def new
    @brand = Brand.new
  end

  def edit
  end

  def update
  end

  def destroy
    @brand = Brand.find(params[:id])
    @brand.destroy
    redirect_to :action => "index"
  end

  def show
    @brand = Brand.find(params[:id])
  end

  def create
    @brand = Brand.new(brand_name: params[:brand][:brand_name])
    if @brand.save
      redirect_to :action => "index"
    else
      render :new
    end
  end
end
