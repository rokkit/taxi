class Orders < ActiveRecord::Base
  establish_connection "mssql"
  self.table_name = "dbo.orders"
  belongs_to :natural_person, foreign_key: "id_client"
  has_one :trip
   def self.calculate_total_bonus client
      orders = client.natural_person.orders
      total = 0
      total_spend_bonus_points = 0
      orders.each do |order|
          total += order.cost_plan * (client.bonus_program.rate/100) if order.trip.nil?
          unless order.trip.nil?
            total_spend_bonus_points += order.trip.bonus_point unless order.trip.try(:bonus_point) == 0
          end
      end
      total# - total_spend_bonus_points
   end

   def to_s
     "#{Russian::strftime datetime_from, '%Y %m %d - %H:%m'}"
   end
end
