json.extract! notification, :id, :member_id, :notification_type, :message, :read_status, :created_at, :created_at, :updated_at
json.url notification_url(notification, format: :json)
