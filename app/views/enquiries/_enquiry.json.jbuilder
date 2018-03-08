json.extract! enquiry, :id, :name, :email, :phone, :subject, :message, :created_at, :updated_at
json.url enquiry_url(enquiry, format: :json)
