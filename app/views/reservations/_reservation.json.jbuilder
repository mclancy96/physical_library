json.extract! reservation, :id, :book_id, :member_id, :reservation_date, :expiration_date, :status, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
