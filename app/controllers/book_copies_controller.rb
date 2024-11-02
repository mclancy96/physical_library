class BookCopiesController < ApplicationController
  before_action :authenticate
  before_action :set_book_copy, only: %i[ show edit update destroy ]

  # GET /book_copies or /book_copies.json
  def index
    @book_copies = BookCopy.all
  end

  # GET /book_copies/1 or /book_copies/1.json
  def show
  end

  # GET /book_copies/new
  def new
    @book_copy = BookCopy.new
  end

  # GET /book_copies/1/edit
  def edit
  end

  # POST /book_copies or /book_copies.json
  def create
    @book_copy = BookCopy.new(book_copy_params)

    respond_to do |format|
      if @book_copy.save
        format.html { redirect_to @book_copy, notice: "Book copy was successfully created." }
        format.json { render :show, status: :created, location: @book_copy }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book_copy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /book_copies/1 or /book_copies/1.json
  def update
    respond_to do |format|
      if @book_copy.update(book_copy_params)
        format.html { redirect_to @book_copy, notice: "Book copy was successfully updated." }
        format.json { render :show, status: :ok, location: @book_copy }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book_copy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /book_copies/1 or /book_copies/1.json
  def destroy
    @book_copy.destroy!

    respond_to do |format|
      format.html { redirect_to book_copies_path, status: :see_other, notice: "Book copy was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book_copy
      @book_copy = BookCopy.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_copy_params
      params.require(:book_copy).permit(:book_id, :barcode, :condition, :acquisition_date, :shelf_location)
    end
end
