angular.module 'hunt'

.service 'hunt', (Api) ->
  new Api '/api/v1'

.factory 'Hunt', (hunt) ->
  Hunt = hunt.model 'hunts'

  Hunt::init = ->
    @area.latitude = parseFloat @area.latitude
    @area.longitude = parseFloat @area.longitude
    @area.distance = parseFloat @area.distance

  Hunt

.factory 'Property', (hunt) ->
  hunt.model 'properties', 'property'

.factory 'User', (hunt) ->
  hunt.model 'users'

