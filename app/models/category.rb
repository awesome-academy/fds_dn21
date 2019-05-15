class Category < ApplicationRecord
  mount_uploader :picture, PictureUploader

  has_many :products

  validate :picture_size

  default_scope{where(is_deleted: false)}

  scope :order_by_name, ->{order :name}
  scope :load_child_categories, (lambda do |category|
    where parent_id: category.id
  end)
  scope :load_categories_by_classify, (lambda do |classify|
    where parent_id: classify
  end)

  private

  def picture_size
    return unless picture.size > Settings.image_size_by_Mb.megabytes
    errors.add :picture, t("error.image_too_big")
  end
end
