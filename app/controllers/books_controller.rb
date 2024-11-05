class BooksController < ApplicationController
  require 'open-uri'

  before_action :authenticate
  before_action :set_book, only: %i[show edit update destroy]
  protect_from_forgery with: :null_session, only: :scan

  # GET /books or /books.json
  def index
    @books = Book.all
  end

  # GET /books/1 or /books/1.json
  def show; end

  # GET /books/new
  def new
    @book = Book.new
  end

  def scan
    isbn = params[:isbn]
    book_data = OpenLibraryService.fetch_book_details(isbn.to_s)
    puts "returned book_date: #{book_data}"

    if book_data
      # Create or find the authors
      authors = book_data[:authors].map do |author|
        puts "author_data: #{author} "
        Author.find_or_create_by(name: author)
      end

      # Create the book record
      book = Book.new(
        title: book_data[:title],
        publication_year: book_data[:publication_year].to_i,
        isbn10: book_data[:isbn10],
        isbn13: book_data[:isbn13],
        page_count: book_data[:number_of_pages].to_i,
      )

      # Download and attach the cover image
      if book_data[:cover_image_url]
        cover_image_file = URI.open(book_data[:cover_image_url])
        book.cover_image.attach(io: cover_image_file, filename: "cover_#{isbn}.jpg")
      end

      if book.save
        genres = book_data[:genres].map do |genre_name|
          Genre.find_or_create_by(name: genre_name)
        end
        book.genres << genres
        book.authors << authors
        flash[:success] = "Successfully added #{book_data[:title]}"
        redirect_to book_path(book)
      else
        flash[:error] = book.errors.full_messages
        redirect_to new_book_path
      end
    else
      flash[:error] = "Book information not found"
      redirect_to new_book_path
    end
  end

  # GET /books/1/edit
  def edit; end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy!

    respond_to do |format|
      format.html { redirect_to books_path, status: :see_other, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def book_data_lookup
    @isbn = params[:isbn]
    service = OpenLibraryService.new(@isbn)
    @book_data = service.fetch_book_data

    if @book_data['error']
      render json: { error: @book_data['error'] }, status: :not_found
    else
      render json: @book_data
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def book_params
    params.require(:book).permit(:title, :author_id, :genre_id, :publication_date, :isbn10, :isbn13, :cover_image)
  end
end
