class MessageText < ActiveRecord::Base
  # scope :welcome, -> where(message_type: 1).first
  def self.welcome
    where(message_type: 1).first
  end
end
