class AddTotalPurchaseToPurchases < ActiveRecord::Migration[5.0]
  def change
    add_column :purchases, :total_purchase, :bigint
  end
end
