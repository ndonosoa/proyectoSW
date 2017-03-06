class AddPurchaseIdToPriceHistories < ActiveRecord::Migration[5.0]
  def change
    add_reference :price_histories, :purchase, foreign_key: true
  end
end
