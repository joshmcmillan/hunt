json.extract! location, :name, :latitude, :longitude

json.distance location.distance unless location.distance.nil?