class AddHumanNameToBonusPrograms < ActiveRecord::Migration
  def change
    add_column :bonus_programs, :human_name, :string
  end
end
