angular.module 'hunt'

.service 'hunt', (Api) ->
  new Api '/api/v1'

.factory 'Location', (hunt) ->
  Location = hunt.model 'locations'

.factory 'Hunt', (hunt, Location) ->
  Hunt = hunt.model 'hunts'

.factory 'Property', (hunt) ->
  Property = hunt.model 'properties', 'property'

.factory 'User', (hunt) ->
  User = hunt.model 'users'

