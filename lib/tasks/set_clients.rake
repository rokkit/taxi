namespace :set_clients do
  desc "Check for new clients"
  task :check_clients => :environment do
    @orders = Orders.actual.limit(50).order("[dbo].[orders].[datetime_to_archive] DESC")
    @orders.each do |order|
        if !order.natural_person.try(:client)
          @phone = order.tel_call_back || order.tel
          if @phone.size > 9
             @phone = "7#{@phone}" if @phone.size == 10
             @phone[0] = "7" if @phone[0] == "8"  
             unless Client.find_by_email @phone
               @client = Client.new(email: @phone, bonus_program: BonusProgram.first, natural_person: order.natural_person)
               @client.save!
             end
          end
        end
        order.reload
        if order.trip.nil? and order.natural_person.present? and order.natural_person.client.present? and order.cost > 0
          trip = Trip.new orders: order, client: order.natural_person.client
          trip.add_bonus_points
          trip.save!
        end
        puts "Client #{order.natural_person.client} processed"
    end
  end
end
