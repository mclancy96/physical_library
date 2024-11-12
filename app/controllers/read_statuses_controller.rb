class ReadStatusesController < ApplicationController
  before_action :authenticate
  before_action :set_read_status, only: %i[update]

  # POST /read_statuses or /read_statuses.json
  def create
    @read_status = ReadStatus.new(read_status_params)

    respond_to do |format|
      if @read_status.save
        format.html { redirect_back(fallback_location: books_path, notice: 'Read status was successfully created.') }
        format.json { render :show, status: :created, location: @read_status }
      else
        format.html { redirect_back(fallback_location: books_path, error: 'Read status was not created.') }
        format.json { render json: @read_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /read_statuses/1 or /read_statuses/1.json
  def update
    if params[:status] == 2 or params[:status] == 3
      borrowing = Borrowing.where(member_id: current_user, book_id: params[:book_id]).first
      borrowing&.destroy
    end
    respond_to do |format|
      if @read_status.update(read_status_params)
        format.html { redirect_back(fallback_location: books_path, notice: 'Read status was successfully updated.') }
        format.json { render :show, status: :ok, location: @read_status }
      else
        format.html { redirect_back(fallback_location: books_path, error: 'Failure to update read status.') }
        format.json { render json: @read_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /read_statuses/1 or /read_statuses/1.json
  # def destroy
  #   @read_status.destroy!
  #
  #   respond_to do |format|
  #     format.html { redirect_to read_statuses_path, status: :see_other, notice: 'Read status was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_read_status
    @read_status = ReadStatus.where(book_id: params[:id], member_id: current_user.id)
                             .where.not(status: [2, 3]).first
  end

  # Only allow a list of trusted parameters through.
  def read_status_params
    params.require(:read_status).permit(:book_id, :member_id, :status, :finished_date, :last_page_read)
  end
end
