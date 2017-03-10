class AddPricePurchaseDetailToPurchaseDetails < ActiveRecord::Migration[5.0]
  def change
    add_column :purchase_details, :price_purchase_detail, :bigint
  end
end
