angular.module('hunt')

.config ($stateProvider, resourceRouterProvider) ->
  resourceRouterProvider.mount $stateProvider,
    path: ['hunts', 'show', 'dashboard']
    views: ['']
    templates: ['main', 'aside']

.controller 'DashboardAsideCtrl', ($scope, session) ->
  session.huntsView = 'dashboard'

.controller 'DashboardMainCtrl', ($scope) ->
  undefined
