class Product < ApplicationRecord

  mount_uploader :picture, PictureUploader

  has_many :rates
  has_many :order_products
  belongs_to :category

  validates :name, presence: true, length:
    {maximum: Settings.name_length_max}
  validates :category_id, presence: true
  validate :picture_size

  default_scope{where(is_deleted: false)}
  scope :order_by_name, ->{order :name}
  scope :load_child_products, ->(category) do
    where category_id: category.id
  end

  private

  def picture_size
    return unless picture.size > Settings.image_size_by_Mb.megabytes
    errors.add :picture, t("error.image_too_big")
  end
end
