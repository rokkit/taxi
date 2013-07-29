class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
  has_and_belongs_to_many :roles
  has_one :account
  def role?(role)
    return !!self.roles.find_by_name(role.to_s)
  end
  before_create :generate_and_send_password_by_sms
  
  accepts_nested_attributes_for :account
  

  private
  def generate_and_send_password_by_sms
    #gen_pass = Devise.friendly_token.first(6)
    #client = Twilio::REST::Client.new(APP['twilio']['sid'], APP['twilio']['token'])
    #client.account.sms.messages.create(
      #from: APP['twilio']['from'],
      #to: "+#{self.email}",
      #body: "таксИ шашечкИ ВАШ пароль!: #{gen_pass}"
    #)
    #self.password = gen_pass
    self.password = "password"
    #update_attribute :password, password
  end

end
