class AddBonusCardToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bonus_card, :string
  end
end
