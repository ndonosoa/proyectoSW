class ProductsController < ApplicationController
  before_action :set_product, only: [:destroy, :show, :update]
  def index
    @product = Product.all
    @product.each do |a|
      Product.where(price_state: 1)
      Product.joins(:prices).where(prices: { price_state: 1 })
    end
  end
  def show

  end

  def update
  end

  def destroy
    @product.destroy
    redirect_to :action => "index"
  end

  def create
    @product = Product.new(product_params)
    if@product.save
      @id = Product.find_by(product_name: params[:product][:product_name])

        @precio = Price.new
        @precio.actual_price = params[:asd]
        @precio.product_id = @id.id
        @precio.price_state = 1
        if @precio.save
            redirect_to :action => 'index'
        else
         render 'new'
        end
    else
     render 'new'
    end

  end

  def new
    @product = Product.new
  end
  def set_product
      @product = Product.find(params[:id])
   end
  def product_params
     params.require(:product).permit(:product_name,:brand_id,:category_id,:product_code,:provider_id,:product_state)
   end
end
