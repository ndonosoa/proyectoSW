class BrandsController < ApplicationController
	before_action :authenticate

	def index
	end

	def getbrands
		list = Brand.where(state_brand: 1)      
		render json: {
			brand: list
			}.to_json	
	end

	def softdelete
		@brand = Brand.find(params[:id])
		@brand.state_brand = 0
		if @brand.save
		else
			render :json => { :errors => @brand.errors }, :status => 422
		end

	end

	def destroy
		
	end

	def edit
		brand = Brand.find(params[:id])
			render json: {
				brand: brand
				}.to_json
	end

	def update

		@brand = Brand.find(params[:id])
		if @brand.update(name_brand: params[:brand][:name_brand])
		else
			render :json => { :errors => @brand.errors }, :status => 422
		end
	end

	def create
		@reactivar = Brand.find_by(name_brand: params[:brand][:name_brand])
		if @reactivar && @reactivar.state_brand == 0
			@reactivar.state_brand = 1
			if @reactivar.save
			else
				render :json => { :errors => @reactivar.errors }, :status => 422
			end
		else
			@asd = Brand.new(name_brand: params[:brand][:name_brand],
								state_brand: 1)
			if @asd.save
			else
				render :json => { :errors => @asd.errors }, :status => 422
			end
		end
   end


end

