class Region < ApplicationRecord
has_many :comunas
validates :name_region, presence: true, uniqueness: true
validates :odeplan_region, presence: true, uniqueness: true
end
