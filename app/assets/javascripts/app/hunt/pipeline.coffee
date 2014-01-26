angular.module('hunt')

.config ($stateProvider, $urlRouterProvider) ->
  $stateProvider
    .state 'hunt.view.pipeline',
      url: '/pipeline'
      controller: 'PipelineCtrl'
      #templateUrl: 'hunt/pipeline.html'
      template: """
        <property-list properties="hunt.properties"></property-list>
      """

.controller 'PipelineCtrl', ($scope, hunt) ->
  $scope.properties = []

  hunt.properties.list (data) ->
    $scope.properties = data

.directive 'propertyCard', ->
  restrict: 'E'
  scope:
    property: '='
  template: """
    <a ui-sref="property.view({id: property.id})">
      <img ng-src="{{property.photos[0].url}}">
      <h2>{{property.name}}</h2>
      <h3>by {{property.agent.name}}</h3>
      <p>Attributes
    </a>
  """

.directive 'propertyList', ->
  restrict: 'E'
  scope:
    properties: '='
  templateUrl: 'hunt/property/list.html'
  controller: ($scope) ->
    $scope.predicates = [
      {slug: 'favourite', name: 'Favourite'}
      {slug: 'price', name: 'Price'}
      {slug: 'date', name: 'Date'}
    ]

