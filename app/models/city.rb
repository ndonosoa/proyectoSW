class City < ApplicationRecord
  belongs_to :region
  has_many :providers
  validates :city_name, presence: true, uniqueness: true
end
