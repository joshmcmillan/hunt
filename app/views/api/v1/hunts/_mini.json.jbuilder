json.extract! hunt, :id, :name, :target_beds

json.target_cost do
  json.unit hunt.target_cost_unit
  json.value hunt.target_cost_value
end

json.users do
  json.array!(hunt.users) do |json, user|
    json.partial! '/api/v1/users/mini', user: user
  end
end

json.locations do
  json.array!(hunt.locations) do |json, location|
    json.partial! '/api/v1/locations/mini', location: location
  end
end