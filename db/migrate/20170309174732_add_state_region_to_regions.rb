class AddStateRegionToRegions < ActiveRecord::Migration[5.0]
  def change
    add_column :regions, :state_region, :integer
  end
end
