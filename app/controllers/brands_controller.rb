class BrandsController < ApplicationController
	before_action :authenticate

	def index
	end

	def getbrands
		list = Brand.all      
		render json: {
			brand: list
			}.to_json	
	end

	def destroy
		@brand = Brand.find(params[:id])
		@brand.destroy
	end

	def edit
		brand = Brand.find(params[:id])
			render json: {
				brand: brand
				}.to_json
	end

	def update
		@brand = Brand.update(brand_params)
	end

	def create
		@brand = Brand.new(brand_params)

		@brand.save

	end

	def brand_params
		params.require(:brand).permit(:name_brand)
	end

end

