class AddSlugToSellerProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :seller_profiles, :slug, :string
    add_index :seller_profiles, :slug, unique: true
  end
end
