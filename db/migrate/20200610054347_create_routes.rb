class CreateRoutes < ActiveRecord::Migration[6.0]
  def change
    create_table :routes do |t|
      t.references :location_a, null: false
      t.references :location_b, null: false

      t.timestamps
    end
  end
end
