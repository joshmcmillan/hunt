angular.module('hunt')

.config ($stateProvider, $urlRouterProvider) ->
  $stateProvider
    .state 'hunts.view.map',
      url: '/map'
      controller: 'MapCtrl'
      templateUrl: 'hunt/hunts/views/map.html'

.controller 'MapCtrl', ($scope) ->
  undefined
