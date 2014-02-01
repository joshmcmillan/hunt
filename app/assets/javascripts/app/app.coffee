angular.module('hunt', [
  'ui.router'
  'templates'
  'session'

  'facebook'
  'socket.io'
  'google.maps'

  'drag-n-drop'
])

.config ($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] =
    $('meta[name=csrf-token]').attr('content')

.config (facebookProvider) ->
  facebookProvider.config.appId = 653928358000497
  facebookProvider.config.channelUrl = '/facebook.channel.html'

.config ($stateProvider, $urlRouterProvider) ->
  $stateProvider
    .state 'index',
      url: '/'
      views:
        main:
          controller: ($state, session) ->
            $state.transitionTo 'hunts.list'

  $urlRouterProvider.otherwise '/'

.run ($rootScope, session) ->
  $rootScope.session = session
