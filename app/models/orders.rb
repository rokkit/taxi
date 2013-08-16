class Orders < ActiveRecord::Base
  establish_connection "mssql"
  self.table_name = "dbo.orders"
  has_one :trip
   def self.calculate_total_bonus client
      orders = client.natural_person.orders
      total = 0
      orders.each do |order|
        unless order.trip.nil?
          total += order.cost_plan * (client.bonus_program.rate/100) if order.trip.bonus_point == 0
        end
      end
      total
   end

   def to_s
     "#{Russian::strftime datetime_from, '%Y %m %d - %H:%m'}"
   end
end
