class ProductsController < ApplicationController

def index
	@product = Product.all

end

def asd
 sql = "select p.id, p.name_product, b.name_brand, c.name_category, a.name_provider 
  from products p 
  inner join brands b on (b.id = p.brand_id) 
  inner join categories c on (c.id = p.category_id)
  inner join providers a on (a.id = p.provider_id)"

   list = ActiveRecord::Base.connection.execute(sql)       
    render json: {
      productos: list
    }.to_json	
end
end
