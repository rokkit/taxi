require 'smssender'
class InformMail < ActiveRecord::Base
  include SMS
  
  belongs_to :client
  
  # belongs_to :user
  
   after_create :send_email_and_sms
  
   private
  
   def send_email_and_sms
     
     SmsDealer.send self.client.email, body.encode
     
   end
end
