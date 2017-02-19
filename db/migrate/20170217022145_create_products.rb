class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name_product
      t.references :brand, foreign_key: true
      t.references :category, foreign_key: true
      t.references :provider, foreign_key: true

      t.timestamps
    end
  end
end
