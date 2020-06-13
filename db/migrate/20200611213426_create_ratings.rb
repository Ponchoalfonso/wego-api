class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.integer :score, limit: 1
      t.references :user_owner, null: false
      t.references :user_passanger, null: false

      t.timestamps
    end
  end
end
