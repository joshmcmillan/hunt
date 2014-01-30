json.array!(@hunts) do |hunt|
  json.partial! 'mini', hunt: hunt
  json.url api_v1_hunt_url(hunt, format: :json)
end
