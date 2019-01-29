json.extract! status, :id, :deployment_id, :deployID, :recieved, :latitude, :longitude, :temperature, :created_at, :updated_at
json.url status_url(status, format: :json)
