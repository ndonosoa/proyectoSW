class Category < ApplicationRecord
has_many :products
validates :name_category, presence: true, uniqueness: true
end
