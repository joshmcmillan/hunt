angular.module('hunt')

.config ($stateProvider) ->
  $stateProvider
    .state 'properties',
      abstract: true
      url: '/properties'
      template: """
        <ui-view/>
      """

    .state 'properties.view',
      url: '/:propertyID'
      controller: 'PropertyViewCtrl'
      templateUrl: 'hunt/properties/view.html'

.controller 'PropertyListCtrl', ($scope, hunt) ->
  $scope.properties = []

  hunt.properties.list()
    .success (data) ->
      $scope.properties = data

.controller 'PropertyViewCtrl', ($scope, $stateParams, hunt) ->
  $scope.property = {}

  hunt.properties.view($stateParams.propertyID)
    .success (data) ->
      $scope.property = data

.directive 'propertyCard', ->
  restrict: 'E'
  scope:
    property: '='
  templateUrl: "hunt/properties/card.html"

.directive 'propertyList', ->
  restrict: 'E'
  scope:
    properties: '='
  templateUrl: 'hunt/properties/list.html'
  controller: ($scope) ->
    $scope.predicates = [
      {slug: 'favourite', name: 'Favourite'}
      {slug: 'price', name: 'Price'}
      {slug: 'date', name: 'Date'}
    ]

