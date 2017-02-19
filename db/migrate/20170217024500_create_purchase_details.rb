class CreatePurchaseDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :purchase_details do |t|
      t.integer :quantity_product
      t.integer :price_purchase_detail
      t.references :purchase, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
