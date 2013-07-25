class Client < User

 before_create :create_account
  private
  def create_account
    self.roles << Role.where(name: "client").first_or_create
    #if self.role? :client
      self.account = Account.create total: 0
    #end
  end

end
