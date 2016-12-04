class AddUserIdToPurchases < ActiveRecord::Migration[5.0]
  def change
    add_reference :purchases, :user, foreign_key: true
  end
end
