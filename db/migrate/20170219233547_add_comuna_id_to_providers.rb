class AddComunaIdToProviders < ActiveRecord::Migration[5.0]
  def change
    add_reference :providers, :comuna, foreign_key: true
  end
end
