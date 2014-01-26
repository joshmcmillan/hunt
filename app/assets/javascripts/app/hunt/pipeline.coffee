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

.directive 'property-card', ->
  template: """
    <a ui-sref="property.view, {id: property.id}">
      <img ng-src="{{property.images[0].src}}>
      <h2>{{property.name}}</h2>
      <p>Attributes
    </a>
  """
  scope:
    property: '='

.directive 'property-list', ->
  template: """
    <button ng-click="predicate = 'favourite'">Favourite</button>
    <button ng-click="predicate = 'price'">Price</button>
    <button ng-click="predicate = 'date'">Date</button>

    <property-card property="property"
      ng-repeat="property in properties|orderBy:predicate">
    </property-card>
  """
  scope:
    properties: '='

