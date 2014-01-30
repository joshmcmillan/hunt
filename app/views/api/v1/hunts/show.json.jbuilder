json.partial! 'mini', hunt: @hunt

json.properties do
  json.array! @hunt.properties, :name, :location
end