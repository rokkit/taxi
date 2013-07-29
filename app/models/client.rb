class Client < User

  has_many :trips
  belongs_to :bonus_program

 before_create :create_account, :assign_bonus_program


 def to_s
   "#{fio} (+#{email})"
 end
  private
  def create_account
    self.roles << Role.where(name: "client").first_or_create
      self.account = Account.create total: 0
  end

  def assign_bonus_program
    self.bonus_program = BonusProgram.where(name: "default").first_or_create
  end

end
