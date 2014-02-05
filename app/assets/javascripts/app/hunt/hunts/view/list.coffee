angular.module('hunt')

.config ($stateProvider, resourceRouterProvider) ->
  resourceRouterProvider.mount $stateProvider,
    path: ['hunts', 'show', 'list']
    views: ['']
    templates: ['main']

.controller 'ListMainCtrl', ($scope, session) ->
  undefined

