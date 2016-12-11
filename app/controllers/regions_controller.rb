class RegionsController < ApplicationController
  def index
    @region = Region.all
  end

  def new
    @region = Region.new
  end

  def create
    @region = Region.new(region_name: params[:region][:region_name])

    if @region.save
      redirect_to @region
    else
      render :new
    end
  end

  def show
     @region = Region.find(params[:id])
  end

  def update
  end
  def edit
  end
  def delete
  end
end
