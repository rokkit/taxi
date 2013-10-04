# encoding: windows-1251
class ClientsController < ApplicationController
  autocomplete :natural_person, :name, display_value: :full_name, scoped: [:search_by_full_name]
  before_filter :authenticate_user!
  before_filter :load_resource, only: :create
  load_and_authorize_resource
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  #def get_autocomplete_items(parameters)
    #super(parameters).search_by_full_name params[:q]
  #end
  # GET /clients
  # GET /clients.json
  def index
    @clients = Client.all
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    #@trips = Trip.all
    @orders = @client.natural_person.orders
    #@orders.each { |o| o.trip = Trip.create if o.trip.nil? }
    @total_bonus = Orders::calculate_total_bonus @client
  end

  # GET /clients/new
  def new
    if params[:natural_person].present?
      natural_person = NaturalPerson.find(params[:natural_person])
      @client = Client.new natural_person: natural_person, email: natural_person.contacts.first.contact_content, fio: "#{natural_person.name} #{natural_person.surname}"
      #@client.natural_person_id NaturalPerson.find(params[:natural_person])
    else
     @client = Client.new
    end
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: 'Клиент успешно добавлен' }
        format.json { render action: 'show', status: :created, location: @client }
      else
        format.html { render action: 'new' }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: 'Информация успешно обновлена' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end
    


    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params[:client].permit!
    end
    def load_resource
      @client= Client.new(client_params)
    end
end
