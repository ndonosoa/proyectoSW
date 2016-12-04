class Region < ApplicationRecord
	has_many :cities
	validates :region_name, presence: true, uniqueness: true
end
