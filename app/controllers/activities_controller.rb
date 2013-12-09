class ActivitiesController < ApplicationController
  def index
    @activities = PublicActivity::Activity.order("created_at desc").limit(15)
    
    date = Date.parse(params[:day] || Date.today.to_s)
    @today_trips = Trip.where(created_at: (date.at_beginning_of_day)..(date.end_of_day))
    @bonus_points_per_day = @today_trips.inject(0) { |sum, t| sum + t.bonus_point }
  end
end
