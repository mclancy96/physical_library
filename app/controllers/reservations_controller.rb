class ReservationsController < ApplicationController
  before_action :authenticate
  before_action :set_reservation, only: %i[ show edit update destroy ]

  # GET /reservations or /reservations.json
  def index
    @reservations = Reservation.all
  end

  # GET /reservations/1 or /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations or /reservations.json
  def create
    if current_user.reservation_count >= 5
      redirect_to books_path, error: 'You already have 5 reservations! You cannot reserve any more books'
    else
      Reservation.create!(book_id: params[:book_id],
                          member_id: params[:member_id],
                          reservation_date: DateTime.current,
                          expiration_date: DateTime.current + 30.days,
                          status: 1)
      redirect_to books_path, notice: 'Book reserved successfully.'
    end
  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1 or /reservations/1.json
  def destroy
    @reservation.destroy unless @reservation.member != current_user
    redirect_to books_path, notice: 'Reservation canceled.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def reservation_params
    params.require(:reservation).permit(:book_id, :member_id, :reservation_date, :expiration_date, :status)
  end
end
