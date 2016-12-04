class Product < ApplicationRecord
  belongs_to :provider
  has_one :brand
  has_one :category
  has_many :stocks
end
