class CreateVehicles < ActiveRecord::Migration[6.0]
  def change
    create_table :vehicles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :brand, limit: 20
      t.string :model, limit: 80
      t.string :plate_code, limit: 14
      t.string :color, limit: 10

      t.timestamps
    end
  end
end
