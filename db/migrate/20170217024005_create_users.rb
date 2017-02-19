class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name_user
      t.string :rut_user
      t.string :email_user
      t.string :password_user
      t.integer :state_user
      t.references :user_type, foreign_key: true

      t.timestamps
    end
  end
end
