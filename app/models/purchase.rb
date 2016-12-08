class Purchase < ApplicationRecord
  belongs_to :provider
  belongs_to :user
  has_one :purchase_state
end
