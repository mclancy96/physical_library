json.extract! book_copy, :id, :book_id, :barcode, :condition, :acquisition_date, :shelf_location, :created_at, :updated_at
json.url book_copy_url(book_copy, format: :json)
