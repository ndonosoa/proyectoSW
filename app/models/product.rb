class Product < ApplicationRecord
  belongs_to :brand
  belongs_to :category
  belongs_to :provider
  has_many :stock_histories
  has_many :price_histories
end
