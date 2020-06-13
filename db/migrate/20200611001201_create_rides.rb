class CreateRides < ActiveRecord::Migration[6.0]
  def change
    create_table :rides do |t|
      t.references :user_owner, null: false
      t.references :route, null: false, foreign_key: true
      t.decimal :total_price
      t.integer :seats, limit: 1
      t.datetime :scheduled_datetime
      t.datetime :departure_datetime
      t.datetime :finished_datetime
      t.boolean :finished, default: false

      t.timestamps
    end
  end
end
