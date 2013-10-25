# encoding: utf-8
require 'smssender'

class Client < User
  include SMS
  
#include ActiveModel::Dirty
  has_many :trips
  belongs_to :bonus_program
  has_one :account
  belongs_to :natural_person


  after_save :bonus_program_changed_callback#, :if => bonus_program.changed?
 before_create :create_account, :assign_bonus_program, :generate_and_send_password
 
 validates :natural_person, presence: true


  accepts_nested_attributes_for :account
   include PublicActivity::Model
  tracked

  tracked owner: ->(controller, model) { controller && controller.current_user } 
  #def natural_person
    #NaturalPerson.find natural_person_id
  #end

 def to_s
   "#{self.natural_person.try { |n| n.full_name.force_encoding("cp1251").encode("utf-8", undef: :replace)} } (+#{email})"
 end
 
 # def fio=(value)
 #     # custom actions
 #     ###
 #     write_attribute(:fio, value.encode('cp1251'))
 #     # this is same as self[:attribute_name] = value
 #   end
 #   
 #   def fio
 #     f = read_attribute(:fio)
 #     f.encode
 #   end
 def total_bonus
   self.trips.inject(0) { |sum, trip| sum + trip.bonus_point }
 end
 def windraw_bonus_points! amount
   amount = amount.to_i
   if self.total_bonus.to_i > amount
     self.windrawed_bonus += amount
     self.save!
   end
 end
   
  private
  def create_account
    pwd =  Devise.friendly_token.first 6
    self.password = self.password_confirmation = pwd
    # Inform.send_password_info(self, pwd).deliver
    self.roles << Role.where(name: "client").first_or_create
      self.account = Account.create total: 0
  end

  def generate_and_send_password
    #gen_pass = Devise.friendly_token.first(6)
    #client = Twilio::REST::Client.new(APP['twilio']['sid'], APP['twilio']['token'])
    #client.account.sms.messages.create(
      #from: APP['twilio']['from'],
      #to: "+#{self.email}",
      #body: "#{gen_pass}"
    #)
    #self.password = Devise.friendly_token.first(6)
    self.password = Devise.friendly_token.first(6)
    SmsDealer.send self.email, "Здравствуйте, вы зарегистрированы в бонусной программе! Ваш пароль #{self.password}"
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
