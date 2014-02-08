###

.factory 'api', (rest) ->
  new rest '/api/v1'

.factory 'Book', (api) ->
  resource 'books'

.factory 'Property' (api) ->
  api.model 'properties', 'property'

###
angular.module 'rest', []

.factory 'Api', ($http, $q, socket) ->
  class Api
    constructor: (@endpoint) ->
      @models = {}

    register: (Model) ->
      @models[Model.plural] = Model
      return
      socket.subscribe "/rocket/#{Model.plural}", (obj) ->
        Model.cache[obj.id] ?= {}
        Model.cache[obj.id].extend obj

    http: (method, url, data) =>
      $http
        url: "#{@endpoint}#{url}.json"
        method: method
        data: data
      .then (response) ->
        console.log 'rest', method, url, response.data
        response.data

    get:  (url, query) -> @http 'get', url, query
    post: (url, params) -> @http 'post', url, params
    put:  (url, params) -> @http 'put',  url, params
    del:  (url) -> @http 'delete', url

    model: (plural, singular) ->
      api = @

      class Model
        @plural = plural
        @singular = singular ?= plural[...plural.length - 1] # Strip trailing s from plural unless given

        @cache = {}

        api.register @

        ### Class Methods ###

        @index: (query) ->
          api.get "/#{@plural}", query
          .then (data) ->
            new Model obj for obj in data

        @show: (id) ->
          if obj = Model.cache[id]
            dfd = $q.defer()
            dfd.resolve obj
            return dfd.promise

          api.get "/#{@plural}/#{id}"
          .then (data) ->
            new Model data

        @update: (id, data) ->
          params = {}
          params[Model.singular] = data
          api.put "/#{Model.plural}", params

        @destroy: (id) ->
          api.del "/#{@plural}/#{id}"
          .then (data) ->
            delete @cache[id]

        ### Instance Methods ###

        constructor: (data, uncached) ->
          angular.extend @, data
          @init()

          # TODO we don't want to cache the minis I guess...
          unless uncached
            Model.cache[@id] = @ if @id

        init: ->
          null

        create: ->
          params = {}
          obj = params[Model.singular] = @
          api.post "/#{Model.plural}", params
          .then (data) ->
            obj.id = data.id
            obj
          .then (obj) ->
            Model.cache[obj.id] = obj

        update: ->
          Model.update @id, @

        destroy: ->
          Model.destroy @id

.factory 'restSocket', (socket, session) ->
  # TODO unsketch
  subscribe: (Model) ->
    socket.subscribe "/rocket/#{session.user.id}/#{Model.plural}", (obj) ->
      Model.cache[obj.id] ?= {}
      Model.cache[obj.id].extend obj

