class PricesController < ApplicationController
  before_action :set_price, only: [:show, :destroy, :update]
  def index
  end

  def new
    @price = Price.new
  end

  def create
    @price = Price.new(price_params)
    @price.save
    redirect_to :action => "stocks/new"
    end
  end

  def update
  end

  def show
  end

  def delete
  end
  def set_price
    @price = Price.find(params[:id])
  end

  def price_params
     params.require(:price).permit(:actual_price,:product_id)
   end
end
