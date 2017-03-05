class ProvidersController < ApplicationController
#before_action :set_provider, only: [:destroy, :edit]

	def index
		@comunas = Comuna.all
	end

	def getproviders
		sql = "SELECT p.id, p.rut_provider, p.name_provider,
			 	p.phone_provider, p.email_provider, c.nombre_comuna 
				FROM providers p 
				INNER JOIN comunas c ON (c.id = p.comuna_id)
				WHERE p.state_provider = 1 "

   list = ActiveRecord::Base.connection.execute(sql)       
    render json: {
      provider: list
    }.to_json		
	end

	def getcomunas
		list = Comuna.all
		render json: {
			comunas: list
		}.to_json		
	end

	#Cambia el estado del proveedor a 0 para que no sea mostrado
	def softdeleteprovider
		@provider = Provider.find(params[:id])
		@provider.state_provider = 0
		if @provider.save
		else
			render :json => { :errors => @provider.errors }, :status => 422
		end	
	end


	def edit
		provider = Provider.find(params[:id])
			render json: {
				provider: provider
				}.to_json
	end

	def update
		a = Provider.find(params[:id])
		if a.update(provider_params)
		else
			render :json => { :errors => a.errors }, :status => 422
		end
	end

	def create
		check_provider = Provider.find_by(rut_provider: params[:provider][:rut_provider])
		if check_provider.state_provider == 0
			check_provider.state_provider = 1
			check_provider.name_provider = params[:provider][:name_provider]
			check_provider.phone_provider = params[:provider][:phone_provider]
			check_provider.comuna_id = params[:provider][:comuna_id]
			check_provider.email_provider = params[:provider][:email_provider]
			if check_provider.save
			else
				render :json => { :errors => check_provider.errors }, :status => 422
			end
		else
			@provider = Provider.new(provider_params)
			@provider.state_provider = 1
			if @provider.save
			else
				render :json => { :errors => @provider.errors }, :status => 422
			end	
		end	

	end

	def provider_params
		params.require(:provider).permit(:name_provider,:rut_provider,:email_provider,:phone_provider, :comuna_id)
	end

end
