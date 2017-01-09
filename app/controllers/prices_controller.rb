class PricesController < ApplicationController
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

  def price_params
     params.require(:price).permit(:actual_price,:product_id)
   end
end
