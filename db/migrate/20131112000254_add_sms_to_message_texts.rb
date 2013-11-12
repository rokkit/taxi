class AddSmsToMessageTexts < ActiveRecord::Migration
  def change
    add_column :message_texts, :sms, :text
  end
end
