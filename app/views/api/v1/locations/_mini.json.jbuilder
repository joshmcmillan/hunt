json.extract! location, :id, :name, :latitude, :longitude

json.distance location.distance unless location.distance.nil?