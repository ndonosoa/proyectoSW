class AddProductIdToPurchaseDetails < ActiveRecord::Migration[5.0]
  def change
    add_reference :purchase_details, :product, foreign_key: true
  end
end
