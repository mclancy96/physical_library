json.extract! member, :id, :name, :email, :join_date, :password_digest, :created_at, :updated_at
json.url member_url(member, format: :json)
