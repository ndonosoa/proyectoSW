class Purchase < ApplicationRecord
  belongs_to :provider
  belongs_to :user
  belongs_to :product
end
