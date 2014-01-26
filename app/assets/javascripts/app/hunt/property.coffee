angular.module('hunt')

.config ($stateProvider, $urlRouterProvider) ->
  $stateProvider
    .state 'property.view',
      url: '/property/:ID'
      controller: 'PropertyViewCtrl'
      templateUrl: 'hunt/property.html'

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

