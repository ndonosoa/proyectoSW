class CitiesController < ApplicationController
	def index
		@city = City.all
	end

	def new
		@city = City.new
	end
	def create
		@city = City.new(city_name: params[:city][:city_name], region_id: params[:city][:region_id])
		if @city.save
			redirect_to @city
		else
			render :new
		end
	end
	def show
		@city = City.find(params[:id])
	end
end
