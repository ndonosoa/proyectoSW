class AddProviderAddressToProviders < ActiveRecord::Migration[5.0]
  def change
    add_column :providers, :provider_address, :string
  end
end
