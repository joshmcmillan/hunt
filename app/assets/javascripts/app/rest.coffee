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
      .then (response) ->
        console.log 'rest', method, url, response.data
        response.data

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
          params = {}
          obj = params[Model.singular] = @
          api.post "/#{Model.plural}", params
          .then (data) ->
            obj.id = data.id

        update: ->
          params = {}
          params[Model.singular] = @
          api.put "/#{Model.plural}", params

        @index: ->
          api.get "/#{@plural}"
          .then (data) ->
            new Model obj for obj in data

        @show: (id) ->
          api.get "/#{@plural}/#{id}"
          .then (data) ->
            new Model data

        @destroy: (id) ->
          api.del "/#{@plural}/#{id}"

