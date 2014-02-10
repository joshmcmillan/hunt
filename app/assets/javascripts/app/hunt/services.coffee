angular.module 'hunt'

.service 'hunt', (Api) ->
  new Api '/api/v1'

.factory 'Location', (hunt) ->
  Location = hunt.model 'locations'

.factory 'Hunt', (hunt, Location) ->
  Hunt = hunt.model 'hunts'

  Hunt::init = ->
    @locations ?= []

  Hunt::addLocation = (options) ->
    @locations.push new Location options

  Hunt

.factory 'Property', (hunt) ->
  Property = hunt.model 'properties', 'property'

.factory 'User', (hunt) ->
  User = hunt.model 'users'

