class CreateStockHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :stock_histories do |t|
      t.integer :price_stock_history
      t.integer :quantity_stock_history
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
