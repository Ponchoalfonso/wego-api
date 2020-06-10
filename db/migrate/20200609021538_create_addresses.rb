class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :country
      t.string :state
      t.string :city
      t.string :suburb
      t.string :street_address
      t.string :interior
      t.integer :zip_code
      t.references :user

      t.timestamps
    end
  end
end
