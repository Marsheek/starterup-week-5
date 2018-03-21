class CreateSellerProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :seller_profiles do |t|
      t.belongs_to :user, foreign_key: true
      t.string :name
      t.text :bio
      t.string :logo
      t.string :address
      t.string :suburb
      t.string :state
      t.string :postcode
      t.string :country
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
