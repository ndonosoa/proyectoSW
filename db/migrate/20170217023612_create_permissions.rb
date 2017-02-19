class CreatePermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :permissions do |t|
      t.string :model_permission
      t.string :method_permission
      t.string :state_permission
      t.references :user_type, foreign_key: true

      t.timestamps
    end
  end
end
