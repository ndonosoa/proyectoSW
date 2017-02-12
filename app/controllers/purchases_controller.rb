class PurchasesController < ApplicationController
  def index
  end

  def new
    @purchase = Purchase.new
  end

  def create
    @prices1 = Price.where(price_state: '1')
    @purchases = Product.where(provider_id: params[:purchase][:provider_id])
    @ordenes = PurchaseDetail.new
    render '_form'
  end
  def _form2
  end
  def delete
  end

  def show
  end
end
