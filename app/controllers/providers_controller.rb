class ProvidersController < ApplicationController
  def index
    @provider = Provider.all
  end

  def show
  end

  def new
    @provider = Provider.new
  end

  def create
    @provider = Provider.new( provider_name: params[:provider][:provider_name],
                                provider_rut: params[:provider][:provider_rut],
                            provider_email: params[:provider][:provider_email],
                              provider_address: params[:provider][:provider_address],
                                provider_tel: params[:provider][:provider_tel],
                                        city_id: params[:provider][:city_id],
                                region_id: params[:provider][:region_id])
    @provider.save
  end

  def update
  end

  def delete
  end
end
