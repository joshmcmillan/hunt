###

.config ($stateProvider, resourceState) ->
  $resourceRouterProvider.mount $stateProvider,
    path: ['hunts', 'show', 'map']
    views: ['index', 'show', 'create', 'view']
    templates: ['main', 'aside']

###
angular.module 'hunt.router'

.provider 'resourceRouter', ->
  defaults =
    base: 'hunt'
    templates: ['main', 'aside']
    views: ['index', 'show']
    urls:
      index: ""
      show: "/{id:[0-9]}" # TODO nest 'destroy' and 'edit'
      new: "/new"
      destroy: "/:id/delete"
      edit: "/:id/edit"

  capitalize = (word) ->
    word[0].toUpperCase() + word[1..]

  camelCase = (words...) ->
    (capitalize word for word in words when word).join ''

  @build = (options) ->
    options ?= {}

    base = options.base || defaults.base
    path = options.path
    templates = options.templates || defaults.templates
    views = options.views || defaults.views
    urls = options.urls || defaults.urls

    resource = options.resource || path[path.length - 1]

    buildViews = (view) ->
      obj = {}
      for template in templates
        segment = path.join '/'
        segment += "/#{view}" if view
        obj[template] =
          templateUrl: "#{base}/#{segment}/#{template}.html"
          controller: camelCase resource, view, template, 'Ctrl'
      obj

    abstract =
      abstract: true
      url: "/#{resource}"
      views: {}
    for template in templates
      abstract.views[template] =
        templateUrl: "#{base}/#{path.join '/'}/#{template}.html"

    states = {}
    states[path.join '.'] = abstract
    for view in views
      name = path.join '.'
      name += ".#{view}" if view
      states[name] =
        url: urls[view]
        views: buildViews view
    states


  # this to the $stateProvider
  @mount = ($stateProvider, args...) ->
    for name, state of @build.apply @, args
      $stateProvider.state name, state

  @.$get = ->
    null

  @

