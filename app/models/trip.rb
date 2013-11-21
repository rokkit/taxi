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
      self.bonus_point = self.orders.cost.to_f / self.client.bonus_program.rate.to_f
    end
  end

  # private
  # def windraw_bonus_points
  #   self.client.account.windraw_bonus_points bonus_point
  # end
  
  def inform_client_by_sms
    # body = "Такси СТ благодарит за поездку. Вам начислено {bonus_point}  балл(а, ов) (Всего: {result_bonus} балл(а, ов)). Выбирай призы на 3001300.ru"
    body = MessageText.trip.sms.encode
    body.sub! "{bonus_point}", self.bonus_point.to_s
    body.sub! "{result_bonus}", self.client.result_bonus.to_s
    # puts body.encode("cp1251")
    InformMail.create client: self.client, body: body.encode("cp1251")
  end
  



end
