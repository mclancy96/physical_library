json.extract! availability_calendar, :id, :book_id, :available_date, :reservation_count, :created_at, :updated_at
json.url availability_calendar_url(availability_calendar, format: :json)
