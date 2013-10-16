# encoding: utf-8

class Operator < User
 before_create :create_account, :generate_and_send_password
 def to_s
   "Оператор: #{email}"
 end
  private
  def create_account
    self.roles << Role.where(name: "operator").first_or_create
  end
  
  def generate_and_send_password
    #gen_pass = Devise.friendly_token.first(6)
    #client = Twilio::REST::Client.new(APP['twilio']['sid'], APP['twilio']['token'])
    #client.account.sms.messages.create(
      #from: APP['twilio']['from'],
      #to: "+#{self.email}",
      #body: "#{gen_pass}"
    #)
    #self.password = gen_pass
    self.password = "password"
    Inform.message_to_operator(self.mail, self.password).send
    #update_attribute :password, password
  end
end
