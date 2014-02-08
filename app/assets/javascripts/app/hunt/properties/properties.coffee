angular.module 'hunt'

.config ($stateProvider, resourceRouterProvider) ->
  resourceRouterProvider.mount $stateProvider,
    path: ['properties']
    views: ['index', 'show', 'new', 'edit']

.run (session, $rootScope) ->
    $rootScope.propertyPredicates = session.propertyPredicates = [
      {slug: 'favourite', name: 'Favourite'}
      {slug: 'price', name: 'Price'}
      {slug: 'date', name: 'Date'}
    ]

.controller 'PropertyShowMainCtrl', ($scope, $stateParams, Property) ->
  $scope.property = {}

  Property.show $stateParams.id
  .then (property) ->
    $scope.property = property

.controller 'PropertyNewMainCtrl', ($scope, Property) ->
  $scope.property = new Property
  $scope.create = ->
    $scope.property.create()
      .then (property) ->
        $state.transitionTo 'property.show', id: property.id
    $scope.property = new Property

.directive 'propertyProgress', ->
  restrict: 'E'
  scope:
    stage: '='

.directive 'propertyThumb', ->
  restrict: 'E'
  scope:
    property: '='
  templateUrl: "hunt/properties/thumb.html"

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

