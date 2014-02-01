angular.module('hunt')

.config ($stateProvider, $urlRouterProvider) ->
  $resourceRouterProvider.mount $stateProvider,
    path: ['hunts', 'show', 'map']
    views: ['show']

  $stateProvider
    .state 'hunts.view.map',
      url: '/map'
      views:
        main:
          #controller: 'MapCtrl'
          templateUrl: 'hunt/hunts/view/map/main.html'
        aside:
          controller: 'MapAsideCtrl'
          templateUrl: 'hunt/hunts/view/map/aside.html'

.run (session) ->
  session.huntsMapFilters = [
    {name: 'Enquired'}
    {name: 'Agent replied'}
    {name: 'View arranged'}
    {name: 'Liked'}
    {name: 'Disliked'}
    {name: 'Unavailable'}
  ]

.controller 'MapAsideCtrl', ($scope, session) ->
  session.huntsView = 'map'
  #$scope.filters = hunt.hunts.map.filters

.controller 'MapCtrl', ($scope, huntsMap) ->
  $scope.filters = hunt.hunts.map.filters

