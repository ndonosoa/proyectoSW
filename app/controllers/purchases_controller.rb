class PurchasesController < ApplicationController
	skip_before_filter :permission
	def index
		
	end

	
	def new
		@providers = Provider.all
		@categories = Category.all
		@brands  = Brand.all 
	end

	def getproductosorden
		sql = "select p.id, p.price_product, p.code_product, p.name_product, b.name_brand, c.name_category, a.name_provider 
		from products p 
		inner join brands b on (b.id = p.brand_id) 
		inner join categories c on (c.id = p.category_id)
		inner join providers a on (a.id = p.provider_id)
		where provider_id="+params[:id]

		list = ActiveRecord::Base.connection.execute(sql)       
		render json: {
			productos: list
			}.to_json	
	end



	def destroy
	end

	def edit
	end

	def update

	end

	def create

	end


end
