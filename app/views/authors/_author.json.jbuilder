json.extract! author, :id, :name, :biography, :dob, :created_at, :updated_at
json.url author_url(author, format: :json)
