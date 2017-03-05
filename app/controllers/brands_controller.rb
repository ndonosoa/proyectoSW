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

		@brand = Brand.find(params[:id])
		if @brand.update(brand_params)
		else
			render :json => { :errors => @brand.errors }, :status => 422
		end
	end

	def create
		@brand = Brand.new(brand_params)

		if @brand.save
		else
    	render :json => { :errors => @brand.errors }, :status => 422
 	 end
   end

	def brand_params
		params.require(:brand).permit(:name_brand)
	end

end

