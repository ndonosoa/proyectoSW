class CreateStocks < ActiveRecord::Migration[5.0]
  def change
    create_table :stocks do |t|
      t.integer :quantity_stock
      t.integer :price_stock
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
