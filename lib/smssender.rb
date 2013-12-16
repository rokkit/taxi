module SMS
  class SMSSender
    def send to, body
    end
  end

  class SmsDealer < SMSSender
    def self.send to, body
      @to = to.to_s
      
      # @to = "7#{@to}" if @to[0] == 9
      @body = body.to_s
      begin
      post_data = Net::HTTP.post_form URI.parse('http://api.lk.smsdiler.ru/delivery.sendSms'),
       { 
         'uid' => APP['smsdealer']['uid'],
         'pid' => APP['smsdealer']['pid'],
         'sender' => MessageText.first.sender.encode("utf-8"),
         'to' => @to,
         'text' => @body,
         'sig' => self.signature()
       }
       handle_respond post_data.body
     rescue Exception => e
       puts "exception"
     end
    end
  
    private 
    def self.signature
      sms_params = "pid=" + APP['smsdealer']['pid'] + "sender=" + MessageText.first.sender.encode("utf-8") + "text=" + @body + "to=" + @to
      signature_text = APP['smsdealer']['uid'] + "delivery.sendSms" + sms_params + APP['smsdealer']['private_api_key']
      Digest::MD5.hexdigest(signature_text)
    end
    def self.handle_respond body
      respond = JSON.parse body
      p respond
    end
  end
end