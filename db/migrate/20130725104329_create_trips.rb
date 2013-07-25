class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.references :user, index: true
      t.datetime :trip_date, null:false
      t.integer :duration
      t.decimal :price, default: 0
      t.integer :bonus_point, default: 0

      t.timestamps
    end
  end
end
