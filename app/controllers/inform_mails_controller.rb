# encoding: utf-8
class InformMailsController < ApplicationController
  before_action :set_inform_mail, only: [:show, :edit, :update, :destroy]

  # GET /inform_mails
  # GET /inform_mails.json
  def index
    @inform_mails = InformMail.all.order("id DESC")
  end
  
  def change_text
    @message_welcome_text = MessageText.welcome || MessageText.create(message_type: 1)
    @message_trip_text = MessageText.trip || MessageText.create(message_type: 2)
    # @message_welcome_text =  MessageText.create(message_type: 1) if @message_welcome_text.nil?
    # @message_welcome_text.sms = @message_welcome_text.sms.encode!
    @message_welcome_text.sms.encode! if @message_welcome_text.sms.present?
    @message_trip_text.sms.encode! if @message_trip_text.sms.present?
    
  end
  
  def do_change_text
    if params[:message_welcome_text].present? && m = MessageText.welcome
      # m.update_attributes(params[:message_welcome_text].permit!)
      m.update_attribute :sms, params[:message_welcome_text][:sms].encode("cp1251")
    end
    if params[:message_trip_text].present? && m = MessageText.trip
      # m.update_attributes(params[:message_welcome_text].permit!)
      m.update_attribute :sms, params[:message_trip_text][:sms].encode("cp1251")
    end
    redirect_to change_text_inform_mails_path
  end

  # GET /inform_mails/1
  # GET /inform_mails/1.json
  def show
  end

  # GET /inform_mails/new
  def new
    @inform_mail = InformMail.new
  end

  # GET /inform_mails/1/edit
  def edit
  end

  # POST /inform_mails
  # POST /inform_mails.json
  def create
    @inform_mail = InformMail.new(inform_mail_params)
    @inform_mail.body.encode!("cp1251")
    respond_to do |format|
      if @inform_mail.save
        format.html { redirect_to inform_mails_path, notice: 'Inform mail was successfully created.' }
        format.json { render action: 'show', status: :created, location: @inform_mail }
      else
        format.html { render action: 'new' }
        format.json { render json: @inform_mail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inform_mails/1
  # PATCH/PUT /inform_mails/1.json
  def update
    respond_to do |format|
      if @inform_mail.update(inform_mail_params)
        format.html { redirect_to @inform_mail, notice: 'Inform mail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @inform_mail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inform_mails/1
  # DELETE /inform_mails/1.json
  def destroy
    @inform_mail.destroy
    respond_to do |format|
      format.html { redirect_to inform_mails_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inform_mail
      @inform_mail = InformMail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inform_mail_params
      params.require(:inform_mail).permit(:client_id, :body)
    end
end
