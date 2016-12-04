class CreateProviders < ActiveRecord::Migration[5.0]
  def change
    create_table :providers do |t|
      t.string :provider_name
      t.string :provider_rut
      t.string :provider_tel
      t.string :provider_email
      t.references :city, foreign_key: true

      t.timestamps
    end
  end
end
