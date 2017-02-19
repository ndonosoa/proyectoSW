class Region < ApplicationRecord
has_many :cities
validates :name_region, presence: true, uniqueness: true
end
