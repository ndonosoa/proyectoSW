class CreatePrices < ActiveRecord::Migration[5.0]
  def change
    create_table :prices do |t|
      t.integer :price_state
      t.integer :actual_price
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
