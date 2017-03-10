class AddStateCategoryToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :state_category, :integer
  end
end
