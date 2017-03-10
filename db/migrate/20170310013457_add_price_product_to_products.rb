class AddPriceProductToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :price_product, :bigint
  end
end
