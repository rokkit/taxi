class Trip < ActiveRecord::Base
  belongs_to :user
  validates :user, presence: true
  def initialize
    super
    self.trip_date = DateTime.now
  end
end
