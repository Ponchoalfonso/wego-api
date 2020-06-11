class CreateDropPoints < ActiveRecord::Migration[6.0]
  def change
    create_table :drop_points do |t|
      t.references :route, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
