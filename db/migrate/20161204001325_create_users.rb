class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :user_pass
      t.string :user_tel
      t.string :user_email
      t.integer :user_state
      t.integer :user_range

      t.timestamps
    end
  end
end
