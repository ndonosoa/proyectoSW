class Provider < ApplicationRecord
  has_one :city
  has_one :region, through: :city
end
