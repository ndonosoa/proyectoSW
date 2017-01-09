class StocksController < ApplicationController
  def new
  	@stock = Stock.new
  end

  def create
  @stock = Stock.new(stock_params)
  	@stock.save
  end

  def update
  end
 def stock_params
     params.require(:stock).permit(:inicial_stock,:product_id)
   end
end
