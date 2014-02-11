angular.module 'hunt'

.config ($stateProvider, resourceRouterProvider) ->
  resourceRouterProvider.mount $stateProvider,
    path: ['hunts', 'show', 'properties']
    views: ['new']
    templates: ['main']

.controller 'PropertiesNewMainCtrl', ($scope, $state, Property) ->
  $scope.location = angular.copy $scope.currentLocation
  $scope.property = new Property
  $scope.create = ->
    $scope.property.create()
      .then (property) ->
        $state.transitionTo 'hunts.show', id: property.hunt.id
        $scope.property = new Property

