class CreateProviders < ActiveRecord::Migration[5.0]
  def change
    create_table :providers do |t|
      t.string :rut_provider
      t.string :name_provider
      t.string :phone_provider
      t.string :email_provider
      t.integer :state_provider

      t.timestamps
    end
  end
end
