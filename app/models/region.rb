class Region < ApplicationRecord
	has_many :cities
	has_many :providers
	validates :region_name, presence: true, uniqueness: true
end
