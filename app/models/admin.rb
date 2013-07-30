class Admin < User
 before_create :create_account
 def to_s
   "Администратор"
 end
  private
  def create_account
    self.roles << Role.where(name: "admin").first_or_create
  end
end
