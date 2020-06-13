class CreatePassengers < ActiveRecord::Migration[6.0]
  def change
    create_table :passengers do |t|
      t.references :ride, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :drop_point, null: false, foreign_key: true
      t.integer :reserved_seats, limit: 1

      t.timestamps
    end
  end
end
