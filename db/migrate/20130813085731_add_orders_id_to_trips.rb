class AddOrdersIdToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :orders_id, :integer
  end
end
