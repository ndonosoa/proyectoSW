class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :product_name
      t.integer :product_state
      t.references :provider, foreign_key: true

      t.timestamps
    end
  end
end
