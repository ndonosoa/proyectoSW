class BrandsController < ApplicationController
  before_action :set_brand, only: [:destroy, :update, :show]
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
    @brand.destroy
    redirect_to :action => "index"
  end

  def show
  end

  def create
    @brand = Brand.new(brand_params)
    if @brand.save
      redirect_to :action => "index"
    else
      render :new
    end
  end

  private
    def set_brand
      @brand = Brand.find(params[:id])
    end

    def brand_params
      params.require(:brand).permit(:brand_name)
    end
end
