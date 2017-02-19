class CreateCities < ActiveRecord::Migration[5.0]
  def change
    create_table :cities do |t|
      t.string :name_city
      t.references :region, foreign_key: true

      t.timestamps
    end
  end
end
