class PurchasesController < ApplicationController
	skip_before_filter :permission
	def index
		@list = Purchase.where(state_purchase: 1)
	end

	
	def new
		@providers = Provider.all
		@categories = Category.all
		@brands  = Brand.all 
	end




	def getdetalleorden
		sql = "select p.id, p.code_product, p.name_product, a.name_provider, 
				d.quantity_product, d.price_purchase_detail, d.product_id
		from purchase_details d

		inner join products p on (p.id = d.product_id)
		inner join providers a on (a.id = p.provider_id)
		where purchase_id="+params[:id]

		list = ActiveRecord::Base.connection.execute(sql)       
		render json: {
			detalle: list
			}.to_json
		
	end

	def getproductosorden
		sql = "select p.id, p.stock_product, p.price_product, p.code_product, p.name_product, b.name_brand, c.name_category, a.name_provider 
		from products p 
		inner join brands b on (b.id = p.brand_id) 
		inner join categories c on (c.id = p.category_id)
		inner join providers a on (a.id = p.provider_id)
		where provider_id="+params[:id]+" and p.state_product = 1"

		list = ActiveRecord::Base.connection.execute(sql)       
		render json: {
			productos: list
			}.to_json	
	end

	def getpurchases
		
		sql = "select p.id, p.total_purchase, p.created_at, a.name_provider
		from purchases p 
		inner join providers a on (a.id = p.provider_id) 
		where state_purchase = 0"


		list = ActiveRecord::Base.connection.execute(sql)       
		render json: {
			purchases: list
			}.to_json
	end
	def getpurchasesd
		
		sql = "select p.id, p.total_purchase, p.created_at, a.name_provider
		from purchases p 
		inner join providers a on (a.id = p.provider_id) 
		where state_purchase = 1"


		list = ActiveRecord::Base.connection.execute(sql)       
		render json: {
			purchasesd: list
			}.to_json
	end

	def destroy
	end

	def edit
	end

	def update

	end



	def updatedetail
		i = params[:cont].to_i
		@purchase = Purchase.find(params[:id])
		@purchase.state_purchase = 1
		cont = 0
		while cont < i
			indice = cont.to_s

			@product_id = params[:obj][:detalles][indice][:product_id]
			@quantity_product = params[:obj][:detalles][indice][:stock_product]
			@price_product = params[:obj][:detalles][indice][:price_product]

			@product = Product.find(@product_id)
			@product.stock_product = @product.stock_product + @quantity_product.to_i
			price_history = PriceHistory.new(product_id: @product_id,
				price_history: @price_product,
				purchase_id: @purchase.id)
			stock_history = StockHistory.new(product_id: @product_id,
				quantity_stock_history: @quantity_product,
				purchase_id: @purchase.id)
			if price_history.save && stock_history.save && @purchase.save && @product.save
				cont = cont + 1
			else
				redirect_to :action => "show"
			end
		end
		
		
	end

	def create
	    #declaracion de variables
	    i = params[:i].to_i
	    a = params[:user_id].to_i
	    cont = 0

		#creacion de nueva orden de compra
		@purchase = Purchase.new(user_id: params[:user_id],
			provider_id: params[:provider_id],
			total_purchase: params[:total_purchase])
		@purchase.state_purchase = 0

		#si la orden de compra se creó satisfactoriamente se crea un detalle de orden de compra
		#recorriendo con un ciclo cada producto que se agregó
		if @purchase.save
			while cont < i	
				#guarda el contador en un indice para aplicar la funcion .to_s solo una vez 
				#y no en cada elemento
				indice = cont.to_s
				#toma los datos del producto y los guarda en una variable para utilizarlos luego
				#la idea es que no ejecute el params completo cada vez
				@product_id = params[:obj][:products][indice][:product_id]
				@quantity_product = params[:obj][:products][indice][:stock_product]
				@price_product = params[:obj][:products][indice][:price_product]

				@purchase_detail = PurchaseDetail.new(purchase_id: @purchase.id,
					quantity_product: @quantity_product,
					price_purchase_detail: @price_product,
					product_id: @product_id)

				#si se creó bien, se deben actualizar los datos de cada producto de ser necesario
				#y se crean tanto un registro de historial de stock y precio correspondientes al producto
				if @purchase_detail.save 
					producto = Product.find(@product_id)
					producto.price_product = @price_product 
					if producto.save
						cont = cont + 1				
					end
				else
					redirect_to :action => "show"		
				end
			end
		else
			redirect_to :action => "new"
		end
	end

end
