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
    users = Orders.actual.includes(:natural_person).order("#{sort_column} #{sort_direction}").page(page).per(per_page)
    if params[:sSearch].present?
      users = users.where("[dbo].[orders].[tel] like :search or [dbo].[orders].[tel_call_back] like :search or [dbo].[orders].[tel] like :search", search: "%#{params[:sSearch]}%")
    end
    if params[:sSearch_0].present?
      left_range, right_range = params[:sSearch_0].split(params[:sRangeSeparator])
      users = users.where("DATEADD(day,DATEDIFF(day,0, [dbo].[orders].[create_date_time]),0) >= DATEADD(day,DATEDIFF(day,0, :left_range),0)", left_range: Date.parse(left_range)) if left_range.present?
      users = users.where("DATEADD(day,DATEDIFF(day,0, [dbo].[orders].[create_date_time]),0) <= DATEADD(day,DATEDIFF(day,0, :right_range),0)", right_range: Date.parse(right_range)) if right_range.present?
    end
    if params[:sSearch_1].present?
      left_range, right_range = params[:sSearch_1].split(params[:sRangeSeparator])
      users = users.where("[dbo].[orders].[datetime_to_archive] >= :left_range", left_range: Date.parse(left_range)) if left_range.present?
      users = users.where("[dbo].[orders].[datetime_to_archive] <= :right_range", right_range: Date.parse(right_range)) if right_range.present?
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