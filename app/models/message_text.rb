class MessageText < ActiveRecord::Base
  # scope :welcome, -> where(message_type: 1).first
  establish_connection "messages"
  def self.welcome
    where(message_type: 1).first
  end
end
