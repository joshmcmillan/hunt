json.partial! 'mini', hunt: @hunt

json.properties do
  json.array!(@hunt.properties) do |json, property|
    json.partial! '/api/v1/properties/mini', property: property
  end
end