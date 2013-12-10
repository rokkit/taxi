class TripsDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: User.count,
      iTotalDisplayRecords: users.total_count,
      aaData: data
    }
  end

private

  def data
    users.each_with_index.map do |order, i|
      if order.natural_person.present?
        [
        
            order.create_date_time.try { |r| r.in_time_zone(ActiveSupport::TimeZone.new("St. Petersburg")).strftime("%d.%m.%y %H:%M") },
            order.datetime_to_archive.try { |r| r.in_time_zone(ActiveSupport::TimeZone.new("St. Petersburg")).strftime("%d.%m.%y %H:%M") },
            (link_to(order.natural_person.client.to_s.encode,  order.natural_person.client) || order.natural_person),
            (order.tel_call_back || order.tel),
            order.route_length,
            order.cost,
            order.trip.try(:bonus_point)
        ]
      
      end
    end
  end

  def users
    @users ||= fetch_users
  end

  def fetch_users
    #order("[dbo].[orders].[datetime_to_archive] DESC")
    users = Orders.actual.order("#{sort_column} #{sort_direction}").page(page).per(per_page)
    if params[:sSearch].present?
      users = users.where("[dbo].[orders].[tel] like :search or [dbo].[orders].[tel_call_back] like :search", search: "%#{params[:sSearch]}%")
    end
    users
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[create_date_time datetime_to_archive tel route_length cost]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "asc" : "desc"
  end
end