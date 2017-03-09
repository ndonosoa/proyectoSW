class Purchase < ApplicationRecord
  belongs_to :provider
  belongs_to :user
  has_many :purchase_details, dependent: :destroy
  has_many :stock_histories, dependent: :destroy
  has_many :price_histories, dependent: :destroy
end
