# encoding: utf-8
class Trip < ActiveRecord::Base
  belongs_to :client
  belongs_to :orders, class_name: "Orders"

  accepts_nested_attributes_for :client,reject_if: proc { |attributes| attributes['email'].blank? }

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


end
