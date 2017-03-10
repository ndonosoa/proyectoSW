class AddStateComunaToComunas < ActiveRecord::Migration[5.0]
  def change
    add_column :comunas, :state_comuna, :integer
  end
end
