json.array!(@trips) do |trip|
  json.extract! trip, :user_id, :trip_date, :duration, :price, :bonus_point
  json.url trip_url(trip, format: :json)
end
