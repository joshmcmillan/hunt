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
  return
  $scope.properties = []

  hunt.api.properties.list (data) ->
    $scope.properties = data

