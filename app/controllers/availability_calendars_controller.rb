class AvailabilityCalendarsController < ApplicationController
  before_action :authenticate
  before_action :set_availability_calendar, only: %i[ show edit update destroy ]

  # GET /availability_calendars or /availability_calendars.json
  def index
    @availability_calendars = AvailabilityCalendar.all
  end

  # GET /availability_calendars/1 or /availability_calendars/1.json
  def show
  end

  # GET /availability_calendars/new
  def new
    @availability_calendar = AvailabilityCalendar.new
  end

  # GET /availability_calendars/1/edit
  def edit
  end

  # POST /availability_calendars or /availability_calendars.json
  def create
    @availability_calendar = AvailabilityCalendar.new(availability_calendar_params)

    respond_to do |format|
      if @availability_calendar.save
        format.html { redirect_to @availability_calendar, notice: "Availability calendar was successfully created." }
        format.json { render :show, status: :created, location: @availability_calendar }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @availability_calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /availability_calendars/1 or /availability_calendars/1.json
  def update
    respond_to do |format|
      if @availability_calendar.update(availability_calendar_params)
        format.html { redirect_to @availability_calendar, notice: "Availability calendar was successfully updated." }
        format.json { render :show, status: :ok, location: @availability_calendar }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @availability_calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /availability_calendars/1 or /availability_calendars/1.json
  def destroy
    @availability_calendar.destroy!

    respond_to do |format|
      format.html { redirect_to availability_calendars_path, status: :see_other, notice: "Availability calendar was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_availability_calendar
      @availability_calendar = AvailabilityCalendar.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def availability_calendar_params
      params.require(:availability_calendar).permit(:book_id, :available_date, :reservation_count)
    end
end
