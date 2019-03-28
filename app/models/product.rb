class Product < ApplicationRecord
  has_many :rates
  has_many :cart_products
  belongs_to :category
end
