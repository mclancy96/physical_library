json.extract! borrowing, :id, :book_id, :member_id, :borrow_date, :due_date, :return_date, :status, :created_at, :updated_at
json.url borrowing_url(borrowing, format: :json)
