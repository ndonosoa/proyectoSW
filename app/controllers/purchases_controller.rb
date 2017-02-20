class PurchasesController < ApplicationController
  def index
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
		@provider.city_id = 1
		@provider.state_provider = 1
		@provider.save

	end

	def provider_params
		params.require(:provider).permit(:name_provider,:rut_provider,:email_provider,:phone_provider)
	end

end
