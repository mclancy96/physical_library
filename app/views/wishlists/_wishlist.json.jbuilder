json.extract! wishlist, :id, :member_id, :book_id, :title, :author, :genre_id, :publication_date, :isbn, :request_status, :added_date, :library_response, :created_at, :updated_at
json.url wishlist_url(wishlist, format: :json)
