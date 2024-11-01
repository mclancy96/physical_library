json.extract! read_status, :id, :book_id, :member_id, :status, :finished_date, :created_at, :updated_at
json.url read_status_url(read_status, format: :json)
