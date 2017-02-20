class AddCodeProductToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :code_product, :string
  end
end
