angular.module('hunt')

.config ($stateProvider, resourceRouterProvider) ->
  resourceRouterProvider.mount $stateProvider,
    path: ['hunts', 'show', 'map']
    views: ['']
    templates: ['main', 'aside']

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

.controller 'MapMainCtrl', ($scope) ->
  #$scope.filters = hunt.hunts.map.filters
