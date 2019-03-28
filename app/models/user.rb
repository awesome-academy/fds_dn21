class User < ApplicationRecord
  has_many :suggestions
  has_many :carts
  has_many :rates
end
