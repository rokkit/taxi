class CreateMessageTexts < ActiveRecord::Migration
  # def connection
  #   ActiveRecord::Base.establish_connection("messages").connection
  # end
  def change
    create_table :message_texts do |t|
      t.text :content
      t.integer :message_type

      t.timestamps
    end
  end
end
