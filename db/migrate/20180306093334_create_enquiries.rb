class CreateEnquiries < ActiveRecord::Migration[5.1]
  def change
    create_table :enquiries do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :subject
      t.text :message

      t.timestamps
    end
  end
end
