class Order < ApplicationRecord
  enum status: {ready: 0, accepted: 1, delivering: 2, delivered: 3}

  has_many :order_products
  belongs_to :user

  scope :load_orders_by_user, (lambda do |user|
    where user_id: user.id
  end)
  scope :order_by_created_time, ->{order created_at: :desc}

  delegate :name, :address, :phone, to: :user, prefix: :user
end
