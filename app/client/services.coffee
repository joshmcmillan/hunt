angular.module('hunt')

.service 'hunt', ($http) ->
  properties:
    list: ->
      $http
        method: 'get'
        url: '/mocks/properties.json'

    view: (properyID) ->
      $http
        method: 'get'
        url: '/mocks/property.json'

  users:
    view: (userID) ->
      $http
        method: 'get'
        url: '/mocks/user.json'

  hunts:
    # List all hunts for given user
    list: (userID) ->
      $http
        method: 'get'
        url: '/mocks/hunt.json'

    view: (huntID) ->
      $http
        method: 'get'
        url: '/mocks/hunt.json'


.service 'session', (hunt) ->
  session:
    user: {}

  hunt.users.view (1)
    .success (data) ->
      session.user = data

