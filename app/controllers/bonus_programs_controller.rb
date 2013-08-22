# encoding: utf-8
class BonusProgramsController < ApplicationController
  before_action :set_bonus_program, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_filter :load_resource, only: :create
  load_and_authorize_resource
  

  # GET /bonus_programs
  # GET /bonus_programs.json
  def index
    @bonus_programs = BonusProgram.all
  end

  # GET /bonus_programs/1
  # GET /bonus_programs/1.json
  def show
  end

  # GET /bonus_programs/new
  def new
    @bonus_program = BonusProgram.new
  end

  # GET /bonus_programs/1/edit
  def edit
  end

  # POST /bonus_programs
  # POST /bonus_programs.json
  def create
    @bonus_program = BonusProgram.new(bonus_program_params)

    respond_to do |format|
      if @bonus_program.save
        format.html { redirect_to @bonus_program, notice: 'Бонусная программа успешно добавлена' }
        format.json { render action: 'show', status: :created, location: @bonus_program }
      else
        format.html { render action: 'new' }
        format.json { render json: @bonus_program.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bonus_programs/1
  # PATCH/PUT /bonus_programs/1.json
  def update
    respond_to do |format|
      if @bonus_program.update(bonus_program_params)
        format.html { redirect_to @bonus_program, notice: 'Bonus program was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bonus_program.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bonus_programs/1
  # DELETE /bonus_programs/1.json
  def destroy
    @bonus_program.destroy
    respond_to do |format|
      format.html { redirect_to bonus_programs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bonus_program
      @bonus_program = BonusProgram.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bonus_program_params
      params.require(:bonus_program).permit!
    end
    def load_resource
      @bonus_program= BonusProgram.new(bonus_program_params)
    end
end
