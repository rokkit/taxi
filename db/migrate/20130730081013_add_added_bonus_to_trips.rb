class AddAddedBonusToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :added_bonus, :integer
  end
end
