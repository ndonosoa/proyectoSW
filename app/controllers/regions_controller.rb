class RegionsController < ApplicationController
  #before_action :set_region, only: [:destroy, :edit]

def index
end


 def getregions
    list = Region.all       
    render json: {
      region: list
    }.to_json	
end

def destroy
  @region = Region.find(params[:id])
  @region.destroy
end

def edit
  region = Region.find(params[:id])
	render json: {
		region: region
	}.to_json
end

def update
  @region = Region.update(region_params)
end


def create
    @region = Region.new(region_params)
   if @region.save
   else
      render :json => { :errors => @region.errors }, :status => 422
    end
  end


   def region_params
     params.require(:region).permit(:name_region, :odeplan_region)
   end

end
