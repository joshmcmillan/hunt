angular.module 'hunt'

.service 'hunt', (Api) ->
  new Api '/api/v1'

.factory 'Hunt', (hunt) ->
  hunt.model 'hunts'

.factory 'Property', (hunt) ->
  hunt.model 'properties', 'property'

.factory 'User', (hunt) ->
  hunt.model 'users'

