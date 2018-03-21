class SellerProfile < ApplicationRecord
  belongs_to :user
  has_many :products
  
  validates :address, :suburb, :state, :postcode, :country, presence: true

  geocoded_by :full_address
  after_validation :geocode

  mount_uploader :logo, SellerProfileLogoUploader

  extend FriendlyId
  friendly_id :name, use: :slugged

  def full_address
    [address, suburb, state, postcode, country].join(', ')
  end
end
