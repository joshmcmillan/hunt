angular.module('hunt')

.service 'hunt', ($http, $q, session) ->
  get = (url) ->
    $http
      method: 'get'
      url: '/api/v1' + url

  lister = (resource) ->
    ->
      dfd = $q.defer()

      list = []
      count = 0
      for i in [1, 2]
        service.api[resource].view(i)
          .success (data) ->
            count++
            list.push data
            console.log resource, count, data
            if count is 2
               dfd.resolve list

      success:
        dfd.promise.then
      error:
        dfd.promise.catch

  service =
    api:
      properties:
        list: lister 'properties'
        view: (propertyID) ->
          get "/properties/#{propertyID}"

      users:
        list: lister 'users'
        view: (userID) ->
          get "/users/#{userID}"

      hunts:
        list: ->
          get "/hunts.json"
        view: (huntID) ->
          get "/hunts/#{huntID}.json"



