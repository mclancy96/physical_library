class BooksController < ApplicationController
  require 'open-uri'
  before_action :authenticate
  before_action :set_book, only: %i[show edit update destroy]
  protect_from_forgery with: :null_session, only: :isbn

  # GET /books or /books.json
  def index
    @books = if session[:search_query].present?
               search_term = "%#{session[:search_query].downcase}%"
               puts "Searching for: #{search_term}"

               @books = Book.left_joins(:authors)
                            .where('LOWER(books.title) LIKE :search OR LOWER(authors.name) LIKE :search OR LOWER(books.isbn13) LIKE :search', search: search_term)
                            .order(title: :asc)
             else
               Book.all.order(title: :asc)
             end.paginate(page: params[:page], per_page: 9)
    @book_count = @books.count
    @genres = Genre.rank_genres
  end

  # GET /books/1 or /books/1.json
  def show
    @genres = Genre.rank_genres
    @read_status = ReadStatus.where(member_id: current_user.id, book_id: @book.id)
                             .where.not(status: [2, 3]).first
    if @read_status.present? && (@book.page_count > 0)
      @progress = ((@read_status&.last_page_read.to_f / @book.page_count) * 100).round(2)
    end
  end

  # GET /books/new
  def new
    @book = Book.new
    @authors = ''
    @genres = ''
  end

  def isbn
    isbn = params[:isbn]
    book_data = OpenLibraryService.fetch_book_details_by_isbn(isbn.to_s)
    puts "receive book data: #{book_data}"
    create_book_from_ol_data(book_data)
    if !@book.nil?
      flash[:notice] = "Successfully added #{@book.title}"
      redirect_to book_path(@book)
    else
      redirect_to new_book_path
    end
  end

  def olid
    olid = params[:olid]
    book_data = OpenLibraryService.fetch_book_details_by_olid(olid.to_s)
    puts "receive book data: #{book_data}"
    create_book_from_ol_data(book_data)
    if !@book.nil?
      flash[:notice] = "Successfully added #{@book.title}"
      redirect_to book_path(@book)
    else
      redirect_to new_book_path
    end
  end

  # GET /books/1/edit
  def edit
    @authors = @book.authors.pluck(:name).join(', ')
    @genres = @book.genres.pluck(:name).join(', ')
  end

  # POST /books or /books.json
  def create
    if (book_params[:isbn10].nil? || book_params[:isbn10] == '') &&
      (book_params[:isbn13].nil? || book_params[:isbn13] == '')
      flash[:error] = 'Must include ISBN10 or ISBN13'
      redirect_to new_book_path
      return false
    end

    if book_params[:author_id]
      authors = book_params[:author_id].split(', ').uniq.map do |author_name|
        author_name_downcase = author_name.downcase
        author = Author.where('LOWER(name) = ?', author_name_downcase).first_or_initialize
        author.name = author_name.capitalize if author.new_record?
        author.save
        author
      end
    end

    if book_params[:genre_id]
      genres = book_params[:genre_id].split(', ').uniq.map do |genre_name|
        genre_name_downcase = genre_name.downcase
        genre = Genre.where('LOWER(name) = ?', genre_name_downcase).first_or_initialize
        genre.name = genre_name.capitalize if genre.new_record?
        genre.save
        genre
      end
    end

    book = Book.new(
      title: book_params[:title],
      publication_year: book_params[:publication_year].to_i,
      isbn10: book_params[:isbn10].nil? || book_params[:isbn10] == '' ? ISBN.ten(book_params[:isbn13].to_s) : book_params[:isbn10],
      isbn13: book_params[:isbn13].nil? || book_params[:isbn13] == '' ? ISBN.thirteen(book_params[:isbn10].to_s) : book_params[:isbn13],
      page_count: book_params[:page_count].to_i
    )

    book.cover_image.attach(book_params[:cover_image]) if book_params && book_params[:cover_image].present?

    if book.save
      book.genres << genres if genres
      book.authors << authors if authors
      flash[:success] = "Successfully added #{book.title}"
      redirect_to book
    else
      flash[:error] = 'Error creating book'
      redirect_to new_book_path
    end

  rescue StandardError => e
    Rails.logger.error "Failed to add book: #{e.message}"
    Rails.logger.error "Failed to add book: #{e.backtrace&.join("\n")}"
    flash[:error] = "Failed to add book: #{e.message}"
    redirect_to new_book_path
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    if (book_params[:isbn10].nil? || book_params[:isbn10] == '') &&
      (book_params[:isbn13].nil? || book_params[:isbn13] == '')
      flash[:error] = 'Must include ISBN10 or ISBN13'
      redirect_to book_path(@book) and return
    end

    if book_params[:author_id]
      authors = book_params[:author_id].split(', ').uniq.map do |author_name|
        author_name_downcase = author_name.downcase
        author = Author.where('LOWER(name) = ?', author_name_downcase).first_or_initialize
        author.name = author_name.capitalize if author.new_record?
        author.save
        author
      end
    end

    if book_params[:genre_id]
      genres = book_params[:genre_id].split(', ').uniq.map do |genre_name|
        genre_name_downcase = genre_name.downcase
        genre = Genre.where('LOWER(name) = ?', genre_name_downcase).first_or_initialize
        genre.name = genre_name.capitalize if genre.new_record?
        genre.save
        genre
      end
    end

    @book.title = book_params[:title] if book_params[:title].present?
    @book.publication_year = book_params[:publication_year] if book_params[:publication_year].present?
    @book.isbn10 = book_params[:isbn10] if book_params[:isbn10].present?
    @book.isbn13 = book_params[:isbn13] if book_params[:isbn13].present?
    @book.page_count = book_params[:page_count] if book_params[:page_count].present?
    @book.cover_image.attach(book_params[:cover_image]) if book_params[:cover_image].present?

    if @book.save
      BookGenre.where(book_id: @book.id).destroy_all
      AuthorBook.where(book_id: @book.id).destroy_all
      @book.genres << genres if genres
      @book.authors << authors if authors
      flash[:success] = "Successfully updated #{@book.title}"
      redirect_to @book
    else
      flash[:error] = 'Error updating book'
      redirect_to edit_book_path(@book)
    end

  rescue StandardError => e
    Rails.logger.error "Failed to add book: #{e.message}"
    Rails.logger.error "Failed to add book: #{e.backtrace&.join("\n")}"
    flash[:error] = "Failed to add book: #{e.message}"
    redirect_to edit_book_path(@book)
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
    @book_data = OpenLibraryService.fetch_book_details_by_isbn(@isbn)
    if @book_data['errors']
      render json: { error: @book_data['errors'] }, status: :not_found
    else
      render json: @book_data
    end
  end

  def search
    if params[:query].present?
      session[:search_query] = params[:query].to_s.strip
    else
      session.delete(:search_query)
    end
    redirect_to books_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.includes(:genres).find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def book_params
    params.require(:book).permit(:title, :author_id, :genre_id, :publication_year, :isbn10, :isbn13, :cover_image,
                                 :page_count)
  end

  def remove_attachments
    @book.cover_image.purge if @book.cover_image.attached?
  end

  def create_book_from_ol_data(book_data)
    puts "in the create book form: #{book_data}"
    if book_data&.is_a?(Hash)
      book_count = book_data[:isbn13].nil? ? Book.where('LOWER(title) like ?', book_data[:title]&.downcase).count : Book.where(isbn13: book_data[:isbn13]).count
      begin
        ActiveRecord::Base.transaction do
          # Create or find the authors and genres
          if book_data[:authors]
            authors = book_data[:authors].uniq.map do |author_name|
              author_name_capitalized = author_name.downcase.titleize # Consistent capitalization
              author = Author.where('LOWER(name) = ?', author_name.downcase).first_or_initialize
              author.name = author_name_capitalized if author.new_record?
              author.save
              author
            rescue ActiveRecord::RecordInvalid => e
              Rails.logger.error "Author validation failed: #{e.message}"
              nil
            end.compact
          end

          if book_data[:genres]
            genres = book_data[:genres].uniq.map do |genre_name|
              genre_name_capitalized = genre_name.downcase.titleize # Consistent capitalization
              genre = Genre.where('LOWER(name) = ?', genre_name.downcase).first_or_initialize
              genre.name = genre_name_capitalized if genre.new_record?
              genre.save
              genre
            rescue ActiveRecord::RecordInvalid => e
              Rails.logger.error "Genre validation failed: #{e.message}"
              nil
            end.compact
          end

          if book_count.zero?
            # Create the book record
            book = Book.new(
              title: book_data[:title],
              publication_year: book_data[:publication_year].to_i,
              isbn10: book_data[:isbn10],
              isbn13: book_data[:isbn13],
              page_count: book_data[:page_count].to_i
            )

            # Download and attach the cover image
            if book_data[:cover_image_url].present?
              cover_image_file = URI.open(book_data[:cover_image_url])
              book.cover_image.attach(io: cover_image_file, filename: "cover_#{book.isbn13.nil? ? olid : book.isbn13 }.jpg")
            end

            if book.save
              book.genres << genres if genres
              book.authors << authors if authors
              @book = book
            end
          else
            flash[:error] = 'Book already exists'
          end
        end
      rescue ActiveRecord::RecordInvalid, OpenURI::HTTPError => e
        Rails.logger.error "Error occurred: #{e.message}"
        Rails.logger.error(e.backtrace&.join("\n"))
        flash[:error] = "An error occurred while adding the book: #{e.message}"
      end
    else
      flash[:error] = 'No book found'
    end
  end
end
