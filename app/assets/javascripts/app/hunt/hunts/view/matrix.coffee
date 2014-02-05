angular.module('hunt')

.config ($stateProvider, resourceRouterProvider) ->
  resourceRouterProvider.mount $stateProvider,
    path: ['hunts', 'show', 'matrix']
    views: ['']
    templates: ['main']

.controller 'MatrixMainCtrl', ($scope, session) ->
  $scope.attributes = [
    {key: 'interested',   name: 'Interested'}
    {key: 'enquired',     name: 'Enquired'}
    {key: 'agentReplied', name: 'Replied'}
    {key: 'viewed',       name: 'Viewed'}
    {key: 'unavailable',  name: 'Ditched'}
  ]

