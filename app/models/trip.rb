class Trip < ActiveRecord::Base
  belongs_to :user
  validates :user, presence: true
  after_create :windraw_bonus_points
  def initialize
    super
    self.trip_date = DateTime.now
  end

  private
  def windraw_bonus_points
    self.user.update
  end
end
