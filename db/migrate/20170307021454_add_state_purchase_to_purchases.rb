class AddStatePurchaseToPurchases < ActiveRecord::Migration[5.0]
  def change
    add_column :purchases, :state_purchase, :integer
  end
end
