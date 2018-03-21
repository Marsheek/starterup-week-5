class Product < ApplicationRecord
  belongs_to :seller_profile



  validates :price, :num_in_stock, numericality: { greater_than_or_equal_to: 0 }

  validates :name, :description, :image, :price, :num_in_stock, presence: true

  mount_uploader :image, ProductImageUploader
end
