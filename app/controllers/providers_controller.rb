class ProvidersController < ApplicationController
  before_action :set_provider, only: [:show, :destroy, :update]
  def index
    @provider = Provider.all
  end

  def show
  end
  def edit
  end
  def new
    @provider = Provider.new
  end

  def create
    @provider = Provider.new(provider_params)
    if @provider.save
      redirect_to :action => "index"
    else
      render :new
    end
  end

  def update
  end

  def destroy
  end

  private
  def set_provider
    @provider = Provider.find(params[:id])
  end
  def provider_params
    params.require(:provider).permit(:provider_name,:provider_rut,:provider_email,:provider_address,:provider_tel,
                                      :city_id,:region_id)
  end
end
