class Client < User

  has_many :trips

 before_create :create_account


 def to_s
   "Клиент #{fio}/ +#{email}"
 end
  private
  def create_account
    self.roles << Role.where(name: "client").first_or_create
      self.account = Account.create total: 0
  end

end
