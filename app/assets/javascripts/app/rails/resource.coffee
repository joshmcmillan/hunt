###

.factory 'api', (rest) ->
  new rest '/api/v1'

.factory 'Book', (api) ->
  resource 'books'

.factory 'Property' (api) ->
  api.model 'properties', 'property'

###


angular.module 'crud', []

.provider 'rest', ($http) ->
  class Api
    constructor: (@endpoint) ->
      null

    http: (method, url, data) =>
      $http
        url: "#{@endpoint}#{url}.json"
        method: method
        data: data

    get:  (url) -> api.http 'get', url
    post: (url, data) -> api.http 'post', url, data
    put:  (url, data) -> api.http 'put', url, data
    del:  (url) -> api.http 'delete', url

    model: (plural, singular) ->
      api = @
      singular ?= plural[...-1] # Strip trailing s from plural unless given

      class Model
        constructor: (data) ->
          angular.extend @, data
          @init()

        init: ->
          null

        create: ->
          data = {}
          obj = data[singular] = @
          api.post "/#{plural}", data
          .then (response) ->
            obj.id = response.id

        update: ->
          data = {}
          data[singular] = @
          api.put "/#{plural}", data

        @index: ->
          api.get "/#{plural}"
          .then (response) ->
            new Model obj for obj in response

        @show: (id) ->
          api.get "/#{plural}/#{id}"
          .then (response) ->
            new Model response

        @destroy: (id) ->
          api.del "/#{plural}/#{id}"

