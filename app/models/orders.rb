class Orders < ActiveRecord::Base
  establish_connection "mssql"
  self.table_name = "dbo.orders"
  belongs_to :natural_person, foreign_key: "id_client"
  has_one :trip
  
  scope :actual, -> { where(id_state: 3).joins(:natural_person).where.not(cost_plan: 0) }
  
   def self.calculate_total_bonus client
      orders = client.natural_person.orders
      total = 0
      total_spend_bonus_points = 0
      orders.each do |order|
        if order.datetime_from > DateTime.new(2013, 10, 1)
          total += order.cost_plan / (client.bonus_program.rate) if order.trip.nil?
          unless order.trip.nil?
            total_spend_bonus_points += order.trip.bonus_point unless order.trip.try(:bonus_point) == 0
          end
        end
      end
      total - client.natural_person.client.windrawed_bonus
   end

   def to_s
     "#{Russian::strftime datetime_from, '%Y %m %d - %H:%m'}"
   end
end
