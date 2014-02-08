angular.module 'hunt.router', []

angular.module('hunt', [
  'hunt.router'

  'ui.router'
  'templates'
  'session'

  'rest'

  'facebook'
  'socket.io'
  'google.maps'

  'drag-n-drop'

])

.constant '_', _
.constant 'io', io
#.constant 'google', google

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
            $state.transitionTo 'hunts.index'

  $urlRouterProvider.otherwise '/'

.run ($rootScope, session) ->
  $rootScope.session = session

.run ($rootScope) ->
  $rootScope.currency =
    unit: 'GBP'
    icon: '£'
