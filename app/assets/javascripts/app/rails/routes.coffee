###

.config ($stateProvider, resourceState) ->
  $resourceRouterProvider.mount $stateProvider,
    path: ['hunts', 'show', 'map']
    views: ['index', 'show', 'create', 'view']
    templates: ['main', 'aside']

###

angular.module 'crud', []

.provider 'resourceRouter', ->
  defaults =
    base: 'app'
    templates: ['main', 'aside']
    views: ['index', 'show']
    urls:
      index: ""
      show: "/:id"  #"/:#{singular}ID"
      create: "/new"
      destroy: "/:id/delete"  #"/:#{singular}ID/delete"
      update:"/:id/delete"  #"/:#{singular}ID/edit"

  capitalize = (word) ->
    word[0].upperCase() + word[1..]

  camelCase = (words...) ->
    (capitalize word for word in words).join ''

  @build = (options) ->  #singular) ->
    options ||= {}

    base = options.base
    path = options.path
    templates = options.templates || defaults.templates
    views = options.views || defaults.views
    urls = options.urls || defaults.urls

    #singular ?= plural[...-1] # Strip trailing s from plural unless given

    buildViews = (view) ->
      obj = {}
      for template in templates
        obj[template] =
          templateUrl: "#{base}/#{path.join '/'}/#{view}/#{template}.html"
          controller: camelCase plural, view, template, 'Ctrl'
      obj

    abstract =
      abstract: true
      url: "/#{path[-1]}"
      views: {}
    for template in options.templates
      abstract.views[template] = "#{base}/#{path.join '/'}/#{template}.html"

    states = {}
    states[path.join '.'] = abstract
    for view in views
      states["#{path.join '.'}.#{view}"] =
        url: urls[view]
        views: buildViews view
    states


  # this to the $stateProvider
  @mount = ($stateProvider, args...) ->
    $stateProvider.state name, state for name, state of @build.call args...

  @.$get = ->
    null

  @

