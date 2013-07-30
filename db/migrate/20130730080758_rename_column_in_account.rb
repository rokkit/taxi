class RenameColumnInAccount < ActiveRecord::Migration
  def change
    rename_column :accounts, :user_id, :client_id
  end
end
