class Operator < User
 before_create :create_account

 def to_s
   "Оператор: #{email}"
 end
  private
  def create_account
    self.roles << Role.where(name: "operator").first_or_create
  end
end
