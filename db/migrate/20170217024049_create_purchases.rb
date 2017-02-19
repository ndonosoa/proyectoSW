class CreatePurchases < ActiveRecord::Migration[5.0]
  def change
    create_table :purchases do |t|
      t.integer :total_purchase
      t.references :provider, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
