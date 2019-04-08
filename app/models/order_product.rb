class OrderProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :product_id, presence: true
  validates :price, presence: true
  validate :quantity_is_available
end
