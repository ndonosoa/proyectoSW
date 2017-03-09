class ProductsController < ApplicationController
skip_before_filter :permission

def index
	@providers = Provider.all
  @brands = Brand.all
  @categories = Category.all
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
  @product.save
end

def create
  @product = Product.new(product_params)
  @product.state_product = 1
  @product.save
end

def product_params
    params.require(:product).permit(:name_product, :price_product,
      :code_product,:brand_id,:category_id, :provider_id, :stock_product)
end

end
