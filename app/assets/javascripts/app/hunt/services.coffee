angular.module('hunt')

.service 'hunt', ($http, $q, session) ->
  get = (url) ->
    $http
      method: 'get'
      url: "/api/v1#{url}.json"

  post = (url, data) ->
    $http
      method: 'post'
      url: '/api/v1' + url
      data: data

  put = (url, data) ->
    $http
      method: 'put'
      url: '/api/v1' + url
      data: data

  del = (url, data) ->
    $http
      method: 'delete'
      url: '/api/v1' + url
      data: data

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
      hunts:
        index: ->
          get "/hunts"
        show: (huntID) ->
          get "/hunts/#{huntID}"
        create: (data) ->
          post "/hunts", hunt: data
        update: (huntID, data) ->
          put "/hunts/#{huntID}", hunt: data
        destroy: (huntID) ->
          del "/hunts/#{huntID}"

      properties:
        index: ->
          get "/properties"
        show: (propertyID) ->
          get "/properties/#{propertyID}"
        create: (data) ->
          post "/properties", property: data

      users:
        index: ->
          get "/users"
        show: (userID) ->
          get "/users/#{userID}"
        create: (data) ->
          post "/users", user: data

