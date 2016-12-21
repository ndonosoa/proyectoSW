class RegionsController < ApplicationController
  before_action :set_region, only: [:destroy,:update,:show]

  def index
    @region = Region.all
  end

  def new
    @region = Region.new
  end

  def create
    @region = Region.new(region_params)

    if @region.save
      redirect_to :action => "index"
    else
      render :new
    end
  end

  def show
  end

  def update
  end
  def edit
  end
  def destroy
    @region.destroy
    redirect_to :action => "index"
  end

  private
   def set_region
     @region = Region.find(params[:id])
   end
   def region_params
     params.require(:region).permit(:region_name)
   end
end
