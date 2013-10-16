# encoding: utf-8
class Trip < ActiveRecord::Base
  belongs_to :client
  belongs_to :orders, class_name: "Orders"
  after_create :discount_price

  accepts_nested_attributes_for :client,reject_if: proc { |attributes| attributes['email'].blank? }

  include PublicActivity::Model
  tracked

  tracked owner: ->(controller, model) { controller && controller.current_user }

  validates :orders, presence: true
  validates :bonus_point, numericality: {greater_than: 0}
  validate :bonus_point_must_be_lower_than_account_total_bonus

  def initialize(attributes = {})
    super
    self.trip_date = DateTime.now
    #self.client = Client.new
  end

  def to_s
    "Поездка №#{self.id}"
  end

  private
  def windraw_bonus_points
    self.client.account.windraw_bonus_points bonus_point
  end
  
  def discount_price
    amount = 0
    if self.orders.cost_plan <= self.bonus_point
      amount = 0
    else
      amount = self.orders.cost_plan - self.bonus_point
    end
    self.orders.cost_plan = amount
    self.orders.save!
  end

  def bonus_point_must_be_lower_than_account_total_bonus
    errors.add :trip, "Недостаточно бонусов" if self.bonus_point.to_f > self.orders.natural_person.client.account.total_bonus_points
  end

  def add_bonus_points
    if self.bonus_point.to_f == 0
      self.added_bonus = price * (self.client.bonus_program.rate/100)
      self.client.account.add_bonus_points price,self.added_bonus
    end
  end
end
