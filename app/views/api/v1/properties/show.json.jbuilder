json.partial! 'mini', property: @property

json.hunt do
  json.partial! '/api/v1/hunts/mini', hunt: @property.hunt
end