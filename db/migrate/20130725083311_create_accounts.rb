class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.decimal :total
      t.references :user, index: true

      t.timestamps
    end
  end
end
