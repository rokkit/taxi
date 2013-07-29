class Admin < User
 before_create :create_account
  private
  def create_account
    self.roles << Role.where(name: "admin").first_or_create
  end
end
