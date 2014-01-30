angular.module('hunt')

.config ($stateProvider) ->
  $stateProvider
    .state 'hunts.view.matrix',
      url: '/matrix'
      views:
        main:
          controller: 'MatrixCtrl'
          templateUrl: 'hunt/hunts/view/matrix/main.html'
        aside:
          templateUrl: 'hunt/hunts/view/matrix/aside.html'

.controller 'MatrixCtrl', ($scope, session) ->
  $scope.attributes = [
    {key: 'interested',   name: 'Interested'}
    {key: 'enquired',     name: 'Enquired'}
    {key: 'agentReplied', name: 'Replied'}
    {key: 'viewed',       name: 'Viewed'}
    {key: 'unavailable',  name: 'Ditched'}
  ]

