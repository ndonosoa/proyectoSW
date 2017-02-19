class AddOdeplanRegionToRegion < ActiveRecord::Migration[5.0]
  def change
    add_column :regions, :odeplan_region, :string
  end
end
