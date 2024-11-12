class BorrowingsController < ApplicationController
  before_action :authenticate
  before_action :set_borrowing, only: %i[new show edit update destroy]

  # GET /borrowings or /borrowings.json
  def index
    @borrowings = Borrowing.all
  end

  # GET /borrowings/1 or /borrowings/1.json
  def show; end

  # GET /borrowings/new
  def new
    @borrowing = Borrowing.new
  end

  # GET /borrowings/1/edit
  def edit; end

  # POST /borrowings or /borrowings.json
  def create
    if current_user.borrowing_count >= 5
      redirect_to books_path, error: 'You already have 5 borrowed books! You cannot borrow any more books'
    else
      Borrowing.create!(
        member_id: params[:member_id],
        book_id: params[:book_id],
        borrow_date: params[:borrow_date] ||= DateTime.current.to_date,
        due_date: params[:due_date] ||= (DateTime.current + 30.day).to_date,
        return_date: params[:return_date] ||= nil,
        status: params[:status] ||= nil
      )
      ReadStatus.create!(
        member_id: params[:member_id],
        book_id: params[:book_id]
      )
      redirect_to books_path, notice: 'Book borrowed successfully.'
    end
  end

  # PATCH/PUT /borrowings/1 or /borrowings/1.json
  def update
    params[:status] ||= params[:status].to_i
    respond_to do |format|
      if @borrowing.update(params)
        format.html { redirect_to @borrowing, notice: "Borrowing was successfully updated." }
        format.json { render :show, status: :ok, location: @borrowing }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @borrowing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /borrowings/1 or /borrowings/1.json
  def destroy
    status = ReadStatus.where(member_id: @borrowing.member_id, book_id: @borrowing.book_id).last
    if status
      status.finished_date = DateTime.now
      status.status = :completed
      status.save!
    end
    @borrowing.destroy unless @borrowing.borrower != current_user

    redirect_to books_path, notice: 'Book returned successfully.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_borrowing
    @borrowing = Borrowing.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def borrowing_params
    params.require(:borrowing).permit(:book_id, :member_id, :borrow_date, :due_date, :return_date, :status)
  end
end
