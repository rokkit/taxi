class CreateBonusPrograms < ActiveRecord::Migration
  def change
    create_table :bonus_programs do |t|
      t.string :name
      t.decimal :rate

      t.timestamps
    end
  end
end
