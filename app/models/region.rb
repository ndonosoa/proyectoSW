class Region < ApplicationRecord
has_many :comunas, dependent: :destroy
validates :name_region, presence: true, uniqueness: true
validates :odeplan_region, presence: true, uniqueness: true
end
