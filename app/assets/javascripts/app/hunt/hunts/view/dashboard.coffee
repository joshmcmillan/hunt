angular.module('hunt')

.config ($stateProvider, resourceRouterProvider) ->
  resourceRouterProvider.mount $stateProvider,
    path: ['hunts', 'show', 'dashboard']
    views: ['']
    templates: ['main', 'aside']

.controller 'DashboardAsideCtrl', ($scope, session) ->
  session.huntsView = 'dashboard'

.controller 'DashboardMainCtrl', ($scope) ->
  $scope.markers = [
    {longitude: 0, latitude: 52}
    {longitude: 1, latitude: 52}
    {longitude: 2, latitude: 52}
    {longitude: 3, latitude: 52}
  ]
