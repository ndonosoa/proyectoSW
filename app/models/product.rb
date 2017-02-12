class Product < ApplicationRecord
  belongs_to :provider
  belongs_to :brand
  belongs_to :category
  has_many :stocks, :dependent => :delete_all
  has_many :prices, :dependent => :delete_all
  has_many :purchase_details
  validates :product_code, uniqueness: true
end
