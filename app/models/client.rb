# encoding: utf-8
require 'smssender'

class Client < User
  include SMS
  
#include ActiveModel::Dirty
  has_many :trips, dependent: :destroy
  belongs_to :bonus_program
  # has_one :account, dependent: :destroy
  belongs_to :natural_person


  # after_save :bonus_program_changed_callback#, :if => bonus_program.changed?
 # before_create  :generate_and_send_password
 after_create :generate_and_send_password
 
 validates :natural_person, presence: true


  # accepts_nested_attributes_for :account
   include PublicActivity::Model
  tracked

  tracked owner: ->(controller, model) { controller && controller.current_user } 
  #def natural_person
    #NaturalPerson.find natural_person_id
  #end

 def to_s
   "#{self.natural_person.try { |n| n.full_name.force_encoding("cp1251").encode("utf-8", undef: :replace)} } (+#{email})"
 end
 
 def result_bonus
   self.total_bonus - self.windrawed_bonus
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
  # def create_account
  #   # pwd =  Devise.friendly_token.first 6 
  #   # self.password = self.password_confirmation = pwd
  #   # Inform.send_password_info(self, pwd).deliver
  #   
  #     # self.account = Account.create total: 0
  # end

  def generate_and_send_password
    self.reload
    update_attribute :password, ('a'..'z').to_a[rand(26)].to_s + (0...5).map{ [rand(10)] }.join
    post_data = Net::HTTP.post_form URI.parse('http://3001300.ru/create_client_from_bonus.php'),
     { 
       'email' => self.email,
       'password' =>  self.password
     }
    mail = InformMail.create! client: self, body: "#{MessageText.welcome.sms.encode} #{self.password}".encode("cp1251")
  end

  def assign_bonus_program
    self.bonus_program = BonusProgram.where(name: "Bazovaya").first_or_create if self.bonus_program.nil?
  end
  

 def bonus_program_changed_callback
   if self.bonus_program_id_changed?
     self.create_activity :bonus_program_change
   end
 end

end
