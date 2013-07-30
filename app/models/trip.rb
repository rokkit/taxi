class Trip < ActiveRecord::Base
  belongs_to :client
  validates :client, presence: true
  after_create :windraw_bonus_points
  accepts_nested_attributes_for :client,reject_if: proc { |attributes| attributes['email'].blank? }

  include PublicActivity::Model
  tracked

  tracked owner: ->(controller, model) { controller && controller.current_user }

  def initialize(attributes = {})
    super
    self.trip_date = DateTime.now
    #self.client = Client.new
  end

  private
  def windraw_bonus_points
    self.client.account.windraw_bonus_points bonus_point
  end
end
