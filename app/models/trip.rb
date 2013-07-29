class Trip < ActiveRecord::Base
  belongs_to :client
  validates :client, presence: true
  after_create :windraw_bonus_points
  def initialize(attributes = {})
    super
    self.trip_date = DateTime.now
  end

  private
  def windraw_bonus_points
    #self.client.update
  end
end
