class RegionsController < ApplicationController
  #before_action :set_region, only: [:destroy, :edit]

def index
end

def show
  
end


 def getregions
    list = Region.where(state_region: 1)      
    render json: {
      region: list
    }.to_json	
end

def softdelete
  @region = Region.find(params[:id])
  @region.state_region = 0
  if @region.save
  else
       render :json => { :errors => @region.errors }, :status => 422
  end
end

def edit
  region = Region.find(params[:id])
	render json: {
		region: region
	}.to_json
end

def update
  @region = Region.find(params[:id])
  if @region.update(region_params)
  else
    render :json => { :errors => @region.errors }, :status => 422
  end

end


def create
    @reactivar = Region.find_by(name_region: params[:region][:name_region])
    if @reactivar && @reactivar.state_region == 0
      @reactivar.state_region = 1
      if @reactivar.save
      else
        render :json => { :errors => @reactivar.errors }, :status => 422
      end
    else
      @asd = Region.new(name_region: params[:region][:name_region],
                state_region: 1,
                  odeplan_region: params[:region][:odeplan_region])
      if @asd.save
      else
        render :json => { :errors => @asd.errors }, :status => 422
      end
    end
   end


   def region_params
     params.require(:region).permit(:name_region, :odeplan_region)
   end

end
