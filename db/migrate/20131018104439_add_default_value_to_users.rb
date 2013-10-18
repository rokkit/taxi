class AddDefaultValueToUsers < ActiveRecord::Migration
  def change
    change_column :users, :windrawed_bonus, :integer, default: 0
  end
end
