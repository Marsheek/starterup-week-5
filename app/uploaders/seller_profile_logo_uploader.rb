class SellerProfileLogoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  # Add a white list of extensions which are allowed to be uplodaer
  # For images you might use something like this
  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
