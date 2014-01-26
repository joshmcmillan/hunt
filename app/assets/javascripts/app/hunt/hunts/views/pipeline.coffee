angular.module('hunt')

.config ($stateProvider) ->
  $stateProvider
    .state 'hunts.view.pipeline',
      url: '/pipeline'
      controller: 'PipelineCtrl'
      #templateUrl: 'hunt/pipeline.html'
      template: """
        <property-list properties="hunt.properties"></property-list>
      """

.controller 'PipelineCtrl', ($scope, hunt) ->
  return
  $scope.properties = []

  hunt.properties.list (data) ->
    $scope.properties = data

