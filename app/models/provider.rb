class Provider < ApplicationRecord
  belongs_to :city
  has_many :purchases
end
