class CreateInformMails < ActiveRecord::Migration
  def change
    create_table :inform_mails do |t|
      t.references :client, index: true
      t.string :body

      t.timestamps
    end
  end
end
