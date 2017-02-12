class ProductsController < ApplicationController
  respond_to :json
  def index
    @product = Product.all
    @prices = Price.where(price_state: '1')
  end
  def show

  end

  def edit   
  end
  def update
    @product.update(product_params)
    if params[:asd] != nil
      precioantiguo = Price.find_by(product_id: @product.id,price_state: '1')
      precioantiguo.update(price_state: '0')
      precioantiguo.save
      @price = Price.new(product_id: params[:id], actual_price: params[:asd], price_state: '1')
      @price.save
    end  
     if @product.save
          redirect_to :action => "index" 
      else
       redirect_to :action => "index"      
     end
  end

  def obj_producto
    @productjs = Product.all
    redirect_to :action => "index"
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



  def product_params
     params.require(:product).permit(:product_name,:brand_id,:category_id,:product_code,:provider_id,:product_state)
   end
end
