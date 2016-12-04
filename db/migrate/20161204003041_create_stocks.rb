class CreateStocks < ActiveRecord::Migration[5.0]
  def change
    create_table :stocks do |t|
      t.integer :inicial_stock
      t.integer :stock_state
      t.integer :actual_stock
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
