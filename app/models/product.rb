class Product < ApplicationRecord
  belongs_to :brand
  belongs_to :category
  belongs_to :provider
  has_many :stock_histories, dependent: :destroy
  has_many :price_histories, dependent: :destroy
  has_many :purchase_detail, dependent: :destroy
end
