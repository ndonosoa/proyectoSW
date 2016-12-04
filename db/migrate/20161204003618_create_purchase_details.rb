class CreatePurchaseDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :purchase_details do |t|
      t.integer :purchase_quantity
      t.integer :purchase_price
      t.references :purchase, foreign_key: true

      t.timestamps
    end
  end
end
