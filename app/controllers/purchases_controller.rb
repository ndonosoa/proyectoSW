class PurchasesController < ApplicationController
	skip_before_filter :permission
	def index
	end

	
	def new
		@providers = Provider.all
		@categories = Category.all
		@brands  = Brand.all 
	end

	def getdetalleorden
		sql = "select p.id, p.code_product, p.name_product, a.name_provider, 
				d.quantity_product, d.price_purchase_detail
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

	def getpurchases
		
		sql = "select p.id, p.total_purchase, p.created_at, a.name_provider
		from purchases p 
		inner join providers a on (a.id = p.provider_id) "
		if session[:current_user] == 1
		sql += "where user_id=" +params[:id]
		end

		list = ActiveRecord::Base.connection.execute(sql)       
		render json: {
			purchases: list
			}.to_json
	end

	def destroy
	end

	def edit
	end

	def update

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
					producto.stock_product = producto.stock_product + @quantity_product.to_i
					producto.price_product = @price_product 
					price_history = PriceHistory.new(product_id: @product_id,
													  price_history: @price_product,
													  purchase_id: @purchase.id)
					stock_history = StockHistory.new(product_id: @product_id,
													  quantity_stock_history: @quantity_product,
													  purchase_id: @purchase.id)
					if producto.save && price_history.save && stock_history.save
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
