# encoding: utf-8
class Inform < ActionMailer::Base
  default from: "from@example.com"

  def send_password_info client, password
    @client = client
    @password = password
    mail(to: @client.mail, subject: 'Бонусная программа Такси 300-1-300')
  end
  
  def message_to_operator to, password
    @password = password
    mail(to: to, subject: 'Бонусная программа Такси 300-1-300')
  end
end
