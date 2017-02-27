class Comuna < ApplicationRecord
  belongs_to :region
  validates :nombre_comuna, presence: true, uniqueness: true
end
