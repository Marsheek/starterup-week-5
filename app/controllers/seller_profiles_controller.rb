class SellerProfilesController < ApplicationController
  before_action :set_seller_profile, only: [:show, :edit, :update, :destroy]

  # GET /seller_profiles
  # GET /seller_profiles.json
  def index
    @seller_profiles = SellerProfile.all
  end

  # GET /seller_profiles/1
  # GET /seller_profiles/1.json
  def show
    @product = Product.new
    @products = @seller_profile.products
  end

  # GET /seller_profiles/new
  def new
    @seller_profile = SellerProfile.new
  end

  # GET /seller_profiles/1/edit
  def edit
  end

  # POST /seller_profiles
  # POST /seller_profiles.json
  def create
    @seller_profile = SellerProfile.new(seller_profile_params)
    @seller_profile.user = current_user
    respond_to do |format|
      if @seller_profile.save
        format.html { redirect_to @seller_profile, notice: 'Seller profile was successfully created.' }
        format.json { render :show, status: :created, location: @seller_profile }
      else
        format.html { render :new }
        format.json { render json: @seller_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /seller_profiles/1
  # PATCH/PUT /seller_profiles/1.json
  def update
    respond_to do |format|
      if @seller_profile.update(seller_profile_params)
        format.html { redirect_to @seller_profile, notice: 'Seller profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @seller_profile }
      else
        format.html { render :edit }
        format.json { render json: @seller_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seller_profiles/1
  # DELETE /seller_profiles/1.json
  def destroy
    @seller_profile.destroy
    respond_to do |format|
      format.html { redirect_to seller_profiles_url, notice: 'Seller profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seller_profile
      @seller_profile = SellerProfile.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def seller_profile_params
      params.require(:seller_profile).permit(:user_id, :name, :bio, :logo, :address, :suburb, :state, :postcode, :country, :latitude, :longitude)
    end
end
