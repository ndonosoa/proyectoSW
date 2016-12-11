class Provider < ApplicationRecord
  belongs_to :city
  belongs_to :region
  has_many :purchases
end
