class ProductsController < ApplicationController
skip_before_filter :permission

def index
	@providers = Provider.where(state_provider: 1)
  @brands = Brand.where(state_brand: 1)
  @categories = Category.where(state_category: 1)
end

def asd
 sql = "select p.stock_product,p.id, p.price_product, p.code_product, p.name_product, b.name_brand, c.name_category, a.name_provider 
  from products p 
  inner join brands b on (b.id = p.brand_id) 
  inner join categories c on (c.id = p.category_id)
  inner join providers a on (a.id = p.provider_id)
  and p.state_product = 1"

   list = ActiveRecord::Base.connection.execute(sql)       
    render json: {
      productos: list
    }.to_json	
end
def gethistorial
  sql = "select ph.price_history, ph.created_at, qh.quantity_stock_history
        from products p
        left join price_histories ph on (ph.product_id = p.id)
        left outer join stock_histories qh on (qh.product_id = p.id)
        where p.id = "+params[:id]+" and ph.purchase_id = qh.purchase_id"

   list = ActiveRecord::Base.connection.execute(sql)       
    render json: {
      historial: list
    }.to_json 
  
end

def edit
    product = Product.find(params[:id])
      render json: {
        product: product
        }.to_json
end

def update
    a = Product.find(params[:id])
    a.update(product_params)
end

def destroy
  @product = Product.find(params[:id])
  @product.state_product = 0
  if @product.save
  else
    render :json => { :errors => @product.errors }, :status => 422
  end
end

def create
    @reactivar = Product.find_by(code_product: params[:product][:code_product])
    if @reactivar && @reactivar.state_product == 0
      @reactivar.state_product = 1
      if @reactivar.save
      else
        render :json => { :errors => @reactivar.errors }, :status => 422
      end
    else
      @asd = Product.new(product_params)
      @asd.state_product = 1
      if @asd.save
      else
        render :json => { :errors => @asd.errors }, :status => 422
      end
    end
   end

def product_params
    params.require(:product).permit(:name_product, :price_product,
      :code_product,:brand_id,:category_id, :provider_id, :stock_product)
end

end
