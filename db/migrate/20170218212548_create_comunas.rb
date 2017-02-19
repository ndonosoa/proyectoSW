class CreateComunas < ActiveRecord::Migration[5.0]
  def change
    create_table :comunas do |t|
      t.string :nombre_comuna
      t.references :region, foreign_key: true

      t.timestamps
    end
  end
end
