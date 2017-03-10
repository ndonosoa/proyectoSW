class AddPriceHistoryToPriceHistories < ActiveRecord::Migration[5.0]
  def change
    add_column :price_histories, :price_histories, :bigint
  end
end
