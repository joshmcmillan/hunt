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

    model: (plural, singular, parent) ->
      api = @

      class Model
        @plural = plural
        @singular = singular ?= plural[...plural.length - 1] # Strip trailing s from plural unless given

        @endpoint = '/' + plural

        @cache = {}

        # TODO
        # These are not used atm, but could be a way to define model fields
        # to send on create/update, or even marshal the data.
        @fields = []
        @schema = {}

        api.register @

        ### Class Methods ###
        @index: (query) ->
          api.get @endpoint, query
          .then (data) =>
            new @ obj for obj in data

        @show: (id) ->
          if obj = @cache[id]
            dfd = $q.defer()
            dfd.resolve obj
            return dfd.promise

          api.get "#{@endpoint}/#{id}"
          .then (data) =>
            new @ data

        @update: (id, data) ->
          params = {}
          params[@singular] = data
          api.put "#{@endpoint}", params

        @destroy: (id) ->
          api.del "#{@endpoint}/#{id}"
          .then (data) =>
            delete @cache[id]

        ### Instance Methods ###

        constructor: (data, uncached) ->
          angular.extend @, data
          @init()

          # TODO we don't want to cache the minis I guess...
          unless uncached
            @constructor.cache[@id] = @ if @id

        init: ->
          null

        create: (owner) ->
          prefix = if owner then "#{owner.constructor.endpoint}/#{owner.id}" else ''
          console.log "CREATING", 'owner', owner
          console.log 'prefix', prefix

          params = {}
          obj = params[@constructor.singular] = @
          api.post "#{prefix}/#{@constructor.endpoint}", params
          .then (data) =>
            obj.id = data.id
            obj
          .then (obj) =>
            console.log 'OBJ', obj
            console.log '@constructor', @constructor
            @constructor.cache[obj.id] = obj
          .then (obj) =>
            (owner[@constructor.plural] ?= []).push obj if owner
            obj

        update: ->
          @constructor.update @id, @

        destroy: ->
          @constructor.destroy @id

.factory 'restSocket', (socket, session) ->
  # TODO unsketch
  subscribe: (Model) ->
    socket.subscribe "/rocket/#{session.user.id}/#{Model.plural}", (obj) ->
      Model.cache[obj.id] ?= {}
      Model.cache[obj.id].extend obj

