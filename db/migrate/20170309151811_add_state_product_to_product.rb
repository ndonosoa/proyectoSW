class AddStateProductToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :state_product, :integer
  end
end
