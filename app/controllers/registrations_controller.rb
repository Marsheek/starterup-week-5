class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    if resource.user_type == 'seller'
      new_seller_profile_path
    end
  end
end
