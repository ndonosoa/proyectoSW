class Provider < ApplicationRecord
  belongs_to :city
  belongs_to :region
  has_many :products
  has_many :purchases
  validates :provider_name, presence: true, uniqueness: true
end
