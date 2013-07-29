class Trip < ActiveRecord::Base
  belongs_to :client
  validates :client, presence: true
  after_create :windraw_bonus_points
  accepts_nested_attributes_for :client,reject_if: proc { |attributes| attributes['email'].blank? }
  def initialize(attributes = {})
    super
    self.trip_date = DateTime.now
    self.client = Client.new
  end

  private
  def windraw_bonus_points
    #self.client.update
  end
end
