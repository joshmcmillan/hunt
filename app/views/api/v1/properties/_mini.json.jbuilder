json.extract! property, :id, 
                        :name, 
                        :enquired, 
                        :agent_replied, 
                        :viewed, 
                        :viewing_time, 
                        :liked,
                        :disliked,
                        :unavailable

json.location do 
  json.partial! '/api/v1/locations/mini', location: property.location
end