class Brand < ApplicationRecord
has_many :products
validates :name_brand, presence: true, uniqueness: true
end
