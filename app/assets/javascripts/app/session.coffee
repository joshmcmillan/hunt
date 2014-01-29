angular.module 'session', [
  'ui.router'
]

.config ($stateProvider, $urlRouterProvider) ->
  $stateProvider
    .state 'login',
      url: '/login'
      controller: 'LoginCtrl'
      templateUrl: 'session/login.html'

.controller 'LoginCtrl', ($scope) ->
  console.log "LoginCtrl"

.service 'session', ->
  undefined

