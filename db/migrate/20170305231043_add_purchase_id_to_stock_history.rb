class AddPurchaseIdToStockHistory < ActiveRecord::Migration[5.0]
  def change
    add_reference :stock_histories, :purchase, foreign_key: true
  end
end
