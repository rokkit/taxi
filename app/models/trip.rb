class Trip < ActiveRecord::Base
  belongs_to :client
  validates :client, presence: true
  after_create :windraw_bonus_points
  before_create :add_bonus_points
  accepts_nested_attributes_for :client,reject_if: proc { |attributes| attributes['email'].blank? }

  include PublicActivity::Model
  tracked

  tracked owner: ->(controller, model) { controller && controller.current_user }

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

  def add_bonus_points
    if self.bonus_point.to_f == 0
      self.added_bonus = price * (self.client.bonus_program.rate/100)
      self.client.account.add_bonus_points price,self.added_bonus
    end
  end
end
