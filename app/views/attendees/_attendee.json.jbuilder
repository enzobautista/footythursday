json.extract! attendee, :id, :name, :created_at, :updated_at
json.url attendee_url(attendee, format: :json)
