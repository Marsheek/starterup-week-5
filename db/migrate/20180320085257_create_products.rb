class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.belongs_to :seller_profile, foreign_key: true
      t.string :name
      t.text :description
      t.string :image
      t.decimal :price
      t.integer :num_in_stock

      t.timestamps
    end
  end
end
