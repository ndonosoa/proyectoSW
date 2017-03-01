class Comuna < ApplicationRecord
  belongs_to :region
  validates :nombre_comuna, presence: true, uniqueness: true
  has_many :providers, dependent: :destroy
end
