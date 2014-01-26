angular.module('hunt', [
  'ui.router'
  'templates'
  'session'

  'facebook'
  'socket.io'
  'google.maps'
])

angular.module('hunt')

.config (facebookProvider) ->
  facebookProvider.config.appId = 653928358000497
  facebookProvider.config.channelUrl = '/facebook.channel.html'

.config ($stateProvider, $urlRouterProvider) ->
  $stateProvider
    .state 'index',
      url: '/'
      controller: ($state, session) ->
        $state.transitionTo 'hunts.list'

  $urlRouterProvider.otherwise '/'

