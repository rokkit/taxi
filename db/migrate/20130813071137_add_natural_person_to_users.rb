class AddNaturalPersonToUsers < ActiveRecord::Migration
  def change
    add_column :users, :natural_person_id, :integer, null: false, default: 1
  end
end
