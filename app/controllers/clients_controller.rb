# encoding: windows-1251
class ClientsController < ApplicationController
  autocomplete :natural_person, :name, display_value: :full_name, scoped: [:search_by_full_name]
  before_filter :authenticate_user!, except: [:set_check, :check]
  before_filter :load_resource, only: :create
  load_and_authorize_resource except: [:set_check, :check]
  before_action :set_client, only: [:show, :edit, :update, :destroy, :windraw_bonus_points]
  #def get_autocomplete_items(parameters)
    #super(parameters).search_by_full_name params[:q]
  #end
  # GET /clients
  # GET /clients.json
  def index
    @clients = Client.all
  end
  
  def windraw_bonus_points
      respond_to do |format|
        if @client.windraw_bonus_points! params[:amount]
          
          format.html { 
            flash[:notice] = 'Списано #{params[:amount]} бонусов'
            redirect_to @client
           }
          format.json { render json: [status: "success"] }
        else
          format.html { 
            flash[:notice] = 'Неверно указано количество баллов'
            redirect_to @client
          }
          format.json { render json: [ status: 'error'], status: :unprocessable_entity }
        end
      end
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    #@trips = Trip.all
    @orders = @client.natural_person.orders.actual.limit(10).order("[dbo].[orders].[id] DESC")
    #@orders.each { |o| o.trip = Trip.create if o.trip.nil? }
    # @total_bonus = Orders::calculate_total_bonus @client
    @total_bonus = (@client.total_bonus) - @client.windrawed_bonus
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
  
  def check
    @orders = Orders.actual.limit(params[:count] || 10).order("[dbo].[orders].[id] DESC")
    @orders.each do |order|
        if !order.natural_person.try(:client)
          @phone = order.tel_call_back || order.tel
          if @phone.size > 9
             @phone = "7#{@phone}" if @phone.size == 10
             @phone[0] = "7" if @phone[0] == "8"  
             unless Client.find_by_email @phone
               @client = Client.new(email: @phone, bonus_program: BonusProgram.first, natural_person: order.natural_person)
               @client.save
             end
          end
        end
        order.reload
        if order.trip.nil? and order.natural_person.present? and order.natural_person.client.present? and order.cost > 0
          trip = Trip.new orders: order, client: order.natural_person.client
          trip.add_bonus_points
          render text: "error: #{trip.errors}" if !trip.save!
        end
    end
    render text: "finish"
  end
  
  def set_check
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
