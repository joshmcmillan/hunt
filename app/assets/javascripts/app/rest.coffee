###

.factory 'api', (rest) ->
  new rest '/api/v1'

.factory 'Book', (api) ->
  resource 'books'

.factory 'Property' (api) ->
  api.model 'properties', 'property'

###
angular.module 'rest', []

.factory 'Api', ($http) ->
  class Api
    constructor: (@endpoint) ->
      null

    http: (method, url, data) =>
      $http
        url: "#{@endpoint}#{url}.json"
        method: method
        data: data

    get:  (url) -> @http 'get', url
    post: (url, data) -> @http 'post', url, data
    put:  (url, data) -> @http 'put', url, data
    del:  (url) -> @http 'delete', url

    model: (plural, singular) ->
      api = @

      class Model
        @plural = plural
        @singular = singular ?= plural[...plural.length - 1] # Strip trailing s from plural unless given

        constructor: (data) ->
          angular.extend @, data
          @init()

        init: ->
          null

        create: ->
          data = {}
          obj = data[Model.singular] = @
          api.post "/#{Model.plural}", data
          .then (response) ->
            obj.id = response.id

        update: ->
          data = {}
          data[Model.singular] = @
          api.put "/#{Model.plural}", data

        @index: ->
          api.get "/#{@plural}"
          .then (response) ->
            new Model obj for obj in response

        @show: (id) ->
          api.get "/#{@plural}/#{id}"
          .then (response) ->
            new Model response

        @destroy: (id) ->
          api.del "/#{@plural}/#{id}"

