class Product < ApplicationRecord
  belongs_to :provider
  belongs_to :brand
  belongs_to :category
  has_many :stocks
  has_many :prices
  has_many :purchase_details
end
