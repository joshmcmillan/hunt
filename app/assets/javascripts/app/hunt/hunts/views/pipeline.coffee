angular.module('hunt')

.config ($stateProvider) ->
  $stateProvider
    .state 'hunts.view.pipeline',
      url: '/pipeline'
      views:
        main:
          controller: 'PipelineCtrl'
          templateUrl: 'hunt/hunts/views/pipeline.html'
        aside:
          templateUrl: 'hunt/hunts/views/pipeline.aside.html'

.controller 'PipelineCtrl', ($scope, session) ->
  session.huntsView = 'pipeline'

  $scope.stages = [
    'interested'
    'enquired'
    'agentReplied'
    'viewed'
    'uavailable'
  ]

  $scope.pipeline = {}

  for stage in $scope.stages
    $scope.pipeline[stage] = []

  $scope.$watch 'hunt.properties', ->
    console.log 'hunt.properties', $scope.hunt.properties
    for property in $scope.hunt.properties || []
      $scope.pipeline[property.stage || $scope.stages[0]].push property
  , true

  return
  $scope.properties = []

  hunt.api.properties.list (data) ->
    $scope.properties = data

