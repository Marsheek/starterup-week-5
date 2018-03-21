json.extract! seller_profile, :id, :user_id, :name, :bio, :logo, :address, :suburb, :state, :postcode, :country, :latitude, :longitude, :created_at, :updated_at
json.url seller_profile_url(seller_profile, format: :json)
