json.extract! review, :id, :book_id, :member_id, :review_text, :rating, :created_at, :created_at, :updated_at
json.url review_url(review, format: :json)
