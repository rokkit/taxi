class CreateMessageTexts < ActiveRecord::Migration
  def change
    create_table :message_texts do |t|
      t.text :content
      t.integer :message_type

      t.timestamps
    end
  end
end
