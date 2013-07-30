class TripsController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  before_action :load_trip, only: :create
  autocomplete :client, :email
  load_and_authorize_resource

  # GET /trips
  # GET /trips.json
  def index
    @trips = Trip.all
  end

  # GET /trips/1
  # GET /trips/1.json
  def show
  end

  # GET /trips/new
  def new
    @trip = Trip.new
    @trip.client  = Client.new
  end

  # GET /trips/1/edit
  def edit
  end

  # POST /trips
  # POST /trips.json
  def create
    unless trip_params[:client_id].blank?
      trip_params.except! :client_attributes
    end

    #raise trip_params.inspect
    #raise trip_params[:client_attributes].inspect

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
      params.require(:trip).permit([:client_id, :trip_date, :duration, :price, :bonus_point, :client_attributes])
    end
    def load_trip
    @trip = Trip.new(trip_params)
    end
end
