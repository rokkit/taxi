class Client < User
#include ActiveModel::Dirty
  has_many :trips
  belongs_to :bonus_program
  has_one :account
  belongs_to :natural_person


  after_save :bonus_program_changed_callback#, :if => bonus_program.changed?
  after_create :send_password
 before_create :create_account, :assign_bonus_program


  accepts_nested_attributes_for :account
   include PublicActivity::Model
  tracked

  tracked owner: ->(controller, model) { controller && controller.current_user } 
  #def natural_person
    #NaturalPerson.find natural_person_id
  #end

 def to_s
   "#{fio} (+#{email})"
 end
  private
  def create_account
    self.roles << Role.where(name: "client").first_or_create
      self.account = Account.create total: 0
  end

  def send_password
    pwd =  Devise.friendly_token.first 6
    self.password = self.password_confirmation = pwd
    Inform.send_password_info(self, pwd).deliver
  end

  def assign_bonus_program
    self.bonus_program = BonusProgram.where(name: "Bazovaya").first_or_create
  end

 def bonus_program_changed_callback
   if self.bonus_program_id_changed?
     self.create_activity :bonus_program_change
   end
 end

end
