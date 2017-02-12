class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :destroy, :update, :edit]
  respond_to :json
  def index
    @product = Product.all
    @prices = Price.where(price_state: '1')
    @products = Product.all.as_json
  end
  def show

  end
  def new
    @product = Product.new
  end
  def edit   
  end
  def update
    if @product.update(product_params)
        if !params[:price].blank?
          precioantiguo = Price.find_by(product_id: @product.id,price_state: '1')
          precioantiguo.price_state = 0
          precioantiguo.save
          @price = Price.new(product_id: params[:id], actual_price: params[:price], price_state: '1')
          @price.save
          redirect_to :action => "index"
          else
          redirect_to :action => "index"
         end 

    end     
  end

  def destroy
    @product.destroy
    redirect_to :action => "index"
  end

  def create
    @product = Product.new(product_params)
    @product.product_state = 1
    if@product.save
      @id = Product.find_by(product_code: params[:product][:product_code])

        @precio = Price.new
        @precio.actual_price = params[:price]
        @precio.product_id = @id.id
        @precio.price_state = 1

        @stock = Stock.new
        @stock.actual_stock = params[:stock]
        @stock.inicial_stock = params[:stock]
        @stock.product_id = @id.id
        @stock.stock_state = 1

        if @precio.save && @stock.save
            redirect_to :action => 'index'
        else
         render 'new'
        end
    else
     render 'new'
    end

  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
     params.require(:product).permit(:product_name,:brand_id,:category_id,:product_code,:provider_id,:product_state)
   end
end
