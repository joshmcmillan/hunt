angular.module('hunt')

.config ($stateProvider) ->
  $stateProvider
    .state 'hunts.view.pipeline',
      url: '/pipeline'
      views:
        main:
          controller: 'PipelineCtrl'
          templateUrl: 'hunt/hunts/view/pipeline/main.html'
        aside:
          templateUrl: 'hunt/hunts/view/pipeline/aside.html'

.controller 'PipelineCtrl', ($scope, session) ->
  session.huntsView = 'pipeline'

  $scope.stages = [
    {key: 'interested',   name: 'Interested'}
    {key: 'enquired',     name: 'Enquired'}
    {key: 'agentReplied', name: 'Replied'}
    {key: 'viewed',       name: 'Viewed'}
    {key: 'unavailable',  name: 'Ditched'}
  ]

  $scope.pipeline = {}

  for stage in $scope.stages
    $scope.pipeline[stage.key] = []

  $scope.$watch 'hunt.properties', ->
    console.log 'hunt.properties', $scope.hunt.properties
    for property in $scope.hunt.properties || []
      $scope.pipeline[property.stage || $scope.stages[0].key].push property
  , true

  return
  $scope.properties = []

  hunt.api.properties.list (data) ->
    $scope.properties = data

