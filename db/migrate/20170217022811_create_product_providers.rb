class CreateProductProviders < ActiveRecord::Migration[5.0]
  def change
    create_table :product_providers do |t|
      t.references :product, foreign_key: true
      t.references :provider, foreign_key: true

      t.timestamps
    end
  end
end
