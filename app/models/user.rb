class User < ApplicationRecord
  has_many :purchases
  validates :password_user, presence: true
end
