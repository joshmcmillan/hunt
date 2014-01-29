angular.module 'facebook', []

.provider 'facebook', ->
  @.config =
    appId      : undefined # App ID
    channelUrl : '/facebook.channel.html' # Channel File
    status     : true      # check login status
    cookie     : true      # enable cookies to give server access to session
    xfbml      : true      # parse XFBML

  @.callbacks = {}

  taskQueue = []

  facebook =
    FB: undefined
    config: @.config
    callbacks: @.callbacks
    session:
      user: null
      status: undefined

  facebook.init = (FB) ->
    facebook.FB = FB
    FB.init facebook.config
    facebook.execute()
    facebook.on 'auth.authResponseChange', facebook.authHandler

  facebook.picture = (id, type_or_width, height) ->
    return null unless id

    query = switch
      when height
        "?width=#{type_or_width}&height=#{height}"
      when type_or_width
        "?type=#{type_or_width}"
      else
        ""

    "https://graph.facebook.com/#{id}/picture#{query}"

  facebook.task = (callback) ->
    taskQueue.push callback

  facebook.sdk = (callback) ->
    if facebook.FB
      callback facebook.FB
    else
      facebook.task callback

  facebook.api = ->
    args = arguments
    facebook.sdk (FB) ->
      FB.api.apply this, args

  # Options include
  # `scope`: the comma separated permissions to be granted by connecting user
  facebook.connect = (options) ->
    facebook.sdk (FB) ->
      FB.login (->), options

  facebook.disconnect = ->
    facebook.sdk (FB) ->
      FB.logout()

  facebook.on = (event, callback) ->
    facebook.sdk (FB) ->
      FB.Event.subscribe event, callback

  facebook.off = (event, callback) ->
    facebook.sdk (FB) ->
      FB.Event.unsubscribe event, callback

  facebook.execute = ->
    # Execute all pending tasks
    while taskQueue.length
      taskQueue.shift() facebook.FB

  facebook.identify = (callback) ->
    facebook.api '/me', (user) ->
      console.log "Good to see you, #{user.name}"
      user.picture = "//graph.facebook.com/#{user.id}/picture?type=large"
      facebook.session.user = user
      facebook.callbacks.identify?()

  facebook.authHandler = (response) ->
    facebook.session.status = response.status
    facebook.session.auth = response.authResponse

    switch response.status
      when 'connected'
        facebook.identify()
      when 'not_authorized'
        facebook.connect()
      else
        facebook.connect()

  facebook

  @.$get = ->
    facebook

  @

.directive 'facebookAsync', ['$window', 'facebook', ($window, facebook) ->
  restrict: 'EA'
  transclude: true
  template: """
  <div ng-transclude></div>
  <div id=fb-root></div>
  """
  link: ->
    id = 'facebook-jssdk'

    $window.fbAsyncInit = ->
      facebook.init $window.FB

    unless $('#'+id).length
      $('<script>',
        id: id
        src: "//connect.facebook.net/en_gb/all.js"
      ).appendTo '#fb-root'
]

.run ['facebook', '$rootScope', '$window', (facebook, $rootScope, $window) ->
  facebook.init $window.FB if $window.FB

  $rootScope.facebook = facebook
]
