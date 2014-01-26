angular.module('hunt')

.config ($stateProvider, $urlRouterProvider) ->
  $stateProvider
    .state 'hunt.view.map',
      url: '/map'
      controller: 'MapCtrl'
      templateUrl: 'hunt/map.html'

.controller 'MapCtrl', ($scope) ->
  undefined
