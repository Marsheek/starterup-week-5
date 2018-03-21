require 'test_helper'

class SellerProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @seller_profile = seller_profiles(:one)
  end

  test "should get index" do
    get seller_profiles_url
    assert_response :success
  end

  test "should get new" do
    get new_seller_profile_url
    assert_response :success
  end

  test "should create seller_profile" do
    assert_difference('SellerProfile.count') do
      post seller_profiles_url, params: { seller_profile: { address: @seller_profile.address, bio: @seller_profile.bio, country: @seller_profile.country, latitude: @seller_profile.latitude, logo: @seller_profile.logo, longitude: @seller_profile.longitude, name: @seller_profile.name, postcode: @seller_profile.postcode, state: @seller_profile.state, suburb: @seller_profile.suburb, user_id: @seller_profile.user_id } }
    end

    assert_redirected_to seller_profile_url(SellerProfile.last)
  end

  test "should show seller_profile" do
    get seller_profile_url(@seller_profile)
    assert_response :success
  end

  test "should get edit" do
    get edit_seller_profile_url(@seller_profile)
    assert_response :success
  end

  test "should update seller_profile" do
    patch seller_profile_url(@seller_profile), params: { seller_profile: { address: @seller_profile.address, bio: @seller_profile.bio, country: @seller_profile.country, latitude: @seller_profile.latitude, logo: @seller_profile.logo, longitude: @seller_profile.longitude, name: @seller_profile.name, postcode: @seller_profile.postcode, state: @seller_profile.state, suburb: @seller_profile.suburb, user_id: @seller_profile.user_id } }
    assert_redirected_to seller_profile_url(@seller_profile)
  end

  test "should destroy seller_profile" do
    assert_difference('SellerProfile.count', -1) do
      delete seller_profile_url(@seller_profile)
    end

    assert_redirected_to seller_profiles_url
  end
end
