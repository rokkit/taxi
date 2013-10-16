# encoding: windows-1251
class TripsController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  before_action :load_trip, only: :create
  autocomplete :client, :email
  load_and_authorize_resource

  # GET /trips
  # GET /trips.json
  def index
    @orders = Orders.includes(:natural_person).limit(15).order("[dbo].[orders].[id] DESC")
  end

  # GET /trips/1
  # GET /trips/1.json
  def show
  end

  # GET /trips/new
  def new
      #@client = Client.find(params[:client])
      order = Orders.find(params[:order_id])
      @client = order.natural_person.client
      @trip = Trip.new orders_id: order
      @trip.orders = order
      @not_bonus_orders =  @client.natural_person.orders.map do |o|
        o if Trip.where(orders: o).blank?
      end
    #@trip.client  = Client.new
  end

  # GET /trips/1/edit
  def edit
  end

  # POST /trips
  # POST /trips.json
  def create
    @trip = Trip.new(trip_params)
    respond_to do |format|
      if @trip.save
        format.html { redirect_to @trip, notice: 'Поездка успешно добавлена' }
        format.json { render action: 'show', status: :created, location: @trip }
      else
        format.html { render action: 'new' }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trips/1
  # PATCH/PUT /trips/1.json
  def update
    respond_to do |format|
      if @trip.update(trip_params)
        format.html { redirect_to @trip, notice: 'Поездка успешно обновлена' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
    @trip.destroy
    respond_to do |format|
      format.html { redirect_to trips_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip
      @trip = Trip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trip_params
      params.require(:trip).permit!#([:client_id, :trip_date, :duration, :price, :bonus_point, :client_attributes])
    end
    def load_trip
    @trip = Trip.new(trip_params)
    end
end
