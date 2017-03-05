class CreatePriceHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :price_histories do |t|
      t.string :price_history
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
