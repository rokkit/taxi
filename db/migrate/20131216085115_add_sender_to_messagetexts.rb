class AddSenderToMessagetexts < ActiveRecord::Migration
  def change
    add_column :message_texts, :sender, :string
  end
end
