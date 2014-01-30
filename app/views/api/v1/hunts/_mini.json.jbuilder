json.extract! hunt, :id, :name, :target_beds

json.target_cost do
  json.unit hunt.target_cost_unit
  json.value hunt.target_cost_value
end

json.users do
  json.array! hunt.users, :id, :name, :avatar
end

json.area do
  json.name hunt.location
  json.latitude hunt.latitude
  json.longitude hunt.longitude
  json.distance hunt.distance
end