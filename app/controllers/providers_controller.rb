class ProvidersController < ApplicationController
#before_action :set_provider, only: [:destroy, :edit]

	def index
		@comunas = Comuna.all
	end

	def getproviders
		sql = "SELECT p.id, p.rut_provider, p.name_provider,
			 	p.phone_provider, p.email_provider, c.nombre_comuna 
				FROM providers p 
				INNER JOIN comunas c ON (c.id = p.comuna_id) "

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

	def destroy
		@provider = Provider.find(params[:id])
		@provider.destroy
	end

	def edit
		provider = Provider.find(params[:id])
			render json: {
				provider: provider
				}.to_json
	end

	def update
		a = Provider.find(params[:id])
		a.update(provider_params)
	end

	def create
		@provider = Provider.new(provider_params)
		@provider.state_provider = 1
		@provider.save

	end

	def provider_params
		params.require(:provider).permit(:name_provider,:rut_provider,:email_provider,:phone_provider, :comuna_id)
	end

end
