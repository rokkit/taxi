module SMS
  class SMSSender
    def send to, body
    end
  end

  class SmsDealer < SMSSender
    def self.send to, body
      p to
      to = "79523707281"
      @to = to.to_s
      @body = body.to_s
      puts "send sms"
      post_data = Net::HTTP.post_form URI.parse('http://api.lk.smsdiler.ru/delivery.sendSms'),
       { 
         'uid' => APP['smsdealer']['uid'],
         'pid' => APP['smsdealer']['pid'],
         'sender' => APP['smsdealer']['sender'],
         'to' => @to,
         'text' => @body,
         'sig' => self.signature()
       }
       handle_respond post_data.body
    end
  
    private 
    def self.signature
      sms_params = "pid=" + APP['smsdealer']['pid'] + "sender=" + APP['smsdealer']['sender'] + "text=" + @body + "to=" + @to
      signature_text = APP['smsdealer']['uid'] + "delivery.sendSms" + sms_params + APP['smsdealer']['private_api_key']
      Digest::MD5.hexdigest(signature_text)
    end
    def self.handle_respond body
      respond = JSON.parse body
      p respond
    end
  end
end