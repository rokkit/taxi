# encoding: utf-8
require 'smssender'

class Trip < ActiveRecord::Base
  include SMS
  belongs_to :client
  belongs_to :orders, class_name: "Orders"

  accepts_nested_attributes_for :client,reject_if: proc { |attributes| attributes['email'].blank? }
  after_create :inform_client_by_sms

  include PublicActivity::Model
  tracked

  tracked owner: ->(controller, model) { controller && controller.current_user }

  validates :orders, presence: true
  validates :bonus_point, numericality: {greater_than: 0}

  def initialize(attributes = {})
    super
    self.trip_date = DateTime.now
    #self.client = Client.new
  end

  def to_s
    "Поездка №#{self.id}"
  end
  def add_bonus_points
    if self.bonus_point.to_f == 0
      self.bonus_point = self.orders.cost_plan.to_f / self.client.bonus_program.rate.to_f
    end
  end

  private
  def windraw_bonus_points
    self.client.account.windraw_bonus_points bonus_point
  end
  
  def inform_client_by_sms
    SmsDealer.send self.client.email, "Такси СТ благодарит за поездку. Данная поездка Вам принесла #{self.bonus_point} баллов (Всего: #{self.client.result_bonus} баллов). Выбирай призы на 3001300.ru"
  end
  



end
