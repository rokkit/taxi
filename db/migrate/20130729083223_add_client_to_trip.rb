class AddClientToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :client_id, :integer
  end
end
