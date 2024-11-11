class BooksController < ApplicationController
  require 'open-uri'
  before_action :authenticate
  before_action :set_book, only: %i[show edit update destroy]
  protect_from_forgery with: :null_session, only: :scan

  # GET /books or /books.json
  def index
    @books = Book.includes(:genres)
    @genres = Genre.rank_genres
  end

  # GET /books/1 or /books/1.json
  def show
    @genres = rank_genres
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  def scan
    isbn = params[:isbn]
    book_data = OpenLibraryService.fetch_book_details(isbn.to_s)
    puts "receive book data: #{book_data}"

    if book_data && book_data[:isbn13]
      begin
        ActiveRecord::Base.transaction do
          # Create or find the authors and genres

          authors = book_data[:authors].uniq.map do |author_name|
            author_name_downcase = author_name.downcase
            author = Author.where('LOWER(name) = ?', author_name_downcase).first_or_initialize
            author.name = author_name.capitalize if author.new_record?
            author.save
            author
          end
          genres = book_data[:genres].uniq.map do |genre_name|
            genre_name_downcase = genre_name.downcase
            genre = Genre.where('LOWER(name) = ?', genre_name_downcase).first_or_initialize
            genre.name = genre_name.capitalize if genre.new_record?
            genre.save
            genre
          end

          if Book.where(isbn13: book_data[:isbn13]).count.zero?
            # Create the book record
            book = Book.new(
              title: book_data[:title],
              publication_year: book_data[:publication_year].to_i,
              isbn10: book_data[:isbn10],
              isbn13: book_data[:isbn13],
              page_count: book_data[:number_of_pages].to_i
            )

            # Download and attach the cover image
            if book_data[:cover_image_url].present?
              cover_image_file = URI.open(book_data[:cover_image_url])
              book.cover_image.attach(io: cover_image_file, filename: "cover_#{isbn}.jpg")
            end

            book.save!
            book.genres << genres
            book.authors << authors

            flash[:success] = "Successfully added #{book_data[:title]}"
            redirect_to book_path(book) and return
          else
            flash[:error] = 'Book already exists'
            redirect_to new_book_path and return
          end
        end
      rescue ActiveRecord::RecordInvalid, OpenURI::HTTPError => e
        Rails.logger.error "Error occurred: #{e.message}"
        Rails.logger.error(e.backtrace&.join("\n"))
        flash[:error] = "An error occurred while adding the book: #{e.message}"
        redirect_to new_book_path
      end
    else
      flash[:error] = 'No book found'
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
    remove_attachments
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

    if @book_data['errors']
      render json: { error: @book_data['errors'] }, status: :not_found
    else
      render json: @book_data
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.includes(:genres).find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def book_params
    params.require(:book).permit(:title, :author_id, :genre_id, :publication_date, :isbn10, :isbn13, :cover_image)
  end

  def remove_attachments
    @book.cover_image.purge if @book.cover_image.attached?
  end
end
