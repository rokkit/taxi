class RemveUnusualFromTrips < ActiveRecord::Migration
  def change
    remove_column :trips, :trip_date
    remove_column :trips, :price
    remove_column :trips, :duration
    remove_column :trips, :client_id
  end
end
