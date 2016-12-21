class CitiesController < ApplicationController
	before_action :set_city, only: [:destroy, :show, :update]
	def index
		@city = City.all
	end

	def new
		@city = City.new
	end
	def create
		@city = City.new(city_params)
		if @city.save
			redirect_to :action => "index"
		else
			render :new
		end
	end
	def show
	end
	def destroy
		@city.destroy
		redirect_to :action => "index"
	end
	def update

	end

	private
	 def set_city
			@city = City.find(params[:id])
	 end
	 def city_params
		 params.require(:city).permit(:city_name, :region_id)
	 end
end
