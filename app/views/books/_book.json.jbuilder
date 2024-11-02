json.extract! book, :id, :title, :author_id, :genre_id, :publication_date, :isbn10, :isbn13, :copies_available, :book_type, :digital_url, :shelf_location, :status, :created_at, :updated_at
json.url book_url(book, format: :json)
