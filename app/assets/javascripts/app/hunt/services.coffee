angular.module('hunt')

.service 'hunt', ($http) ->
  get = (url) ->
    $http
      method: 'get'
      url: '/assets/mocks' + url


  properties:
    list: ->
      get '/properties.json'

    view: (properyID) ->
      get '/property.json'

  users:
    view: (userID) ->
      get '/user.json'

  hunts:
    list: (userID) ->
      get '/hunt.json'

    view: (huntID) ->
      get '/hunt.json'


.service 'session', (hunt) ->
  session:
    user: {}

  hunt.users.view (1)
    .success (data) ->
      session.user = data

