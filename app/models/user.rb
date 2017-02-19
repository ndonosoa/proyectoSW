class User < ApplicationRecord
  belongs_to :user_type
  has_many :purchases
end
