json.extract! product, :id, :seller_profile_id, :name, :description, :image, :price, :num_in_stock, :created_at, :updated_at
json.url product_url(product, format: :json)
