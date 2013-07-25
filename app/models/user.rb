class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
  has_and_belongs_to_many :roles
  has_one :account
  has_many :trips
  def role?(role)
    return !!self.roles.find_by_name(role.to_s)
  end
  after_create :generate_and_send_password_by_sms
  before_create :create_account

  private
  def generate_and_send_password_by_sms
    password = Devise.friendly_token.first(6)
    client = Twilio::REST::Client.new(APP['twilio']['sid'], APP['twilio']['token'])
    client.account.sms.messages.create(
      from: APP['twilio']['from'],
      to: "+#{self.email}",
      body: "таксИ шашечкИ ВАШ пароль!: #{password}"
    )
    update_attribute :password, password
  end

  def create_account
    self.roles << Role.where(name: "client").first_or_create
    #if self.role? :client
      self.account = Account.create total: 0
    #end
  end
end
