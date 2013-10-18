class AddWindrawsBonusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :windrawed_bonus, :integer
  end
end
