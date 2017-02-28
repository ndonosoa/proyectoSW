class AddStockProductToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :stock_product, :integer
  end
end
