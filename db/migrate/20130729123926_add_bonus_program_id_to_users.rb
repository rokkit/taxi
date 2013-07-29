class AddBonusProgramIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bonus_program_id, :integer
  end
end
