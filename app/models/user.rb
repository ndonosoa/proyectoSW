class User < ApplicationRecord
  has_many :purchases
  validates : rut_user, presence: true, confirmation: true, uniqueness: true
  validates : email_user, presence: true, confirmation: true
end
