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
	def revisarjson
		list = purchase_params
		render json: {
			purchase: list
			}.to_json	
	end

	def create
		@purchase = Purchase.new(purchase_params)
		if @purchase.save
			@product = Product.find(asd)
			if @product
			redirect_to :action => "index"
		end
		end		
	end

	def purchase_params
    params.require(:purchase).require(:products).require("0").permit(:user_id,:total_purchase,:provider_id)
	end
	def asd
		params.require(:purchase).require(:products).require("0").permit(:product_id)
		
	end
end
