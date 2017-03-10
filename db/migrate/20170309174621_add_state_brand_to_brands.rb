class AddStateBrandToBrands < ActiveRecord::Migration[5.0]
  def change
    add_column :brands, :state_brand, :integer
  end
end
