class Provider < ApplicationRecord
  belongs_to :comuna
  validates :rut_provider, presence: true, uniqueness: true
  validates :email_provider, presence: true, uniqueness: true
  has_many :products, dependent: :destroy
  has_many :purchases, dependent: :destroy
end
