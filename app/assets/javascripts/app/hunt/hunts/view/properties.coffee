angular.module 'hunt'

.config ($stateProvider, resourceRouterProvider) ->
  $stateProvider
  .state 'hunts.show.properties',
    url: '/properties'
    abstract: true
  .state 'hunts.show.properties.new',
    url: '/new'
    views:
      'main@hunts.show':
        controller: 'PropertiesNewMainCtrl'
        templateUrl: 'hunt/properties/new/main.html'
  ###
      'aside@hunts.show':
        controller: 'PropertiesNewAsideCtrl'
        templateUrl: 'properties/new/aside.html'

  resourceRouterProvider.mount $stateProvider,
    path: ['hunts', 'show', 'properties']
    views: ['new']
    templates: ['main']
  ###

.controller 'PropertiesNewMainCtrl', ($scope, $state, Property) ->
  $scope.property = new Property
  $scope.location = angular.copy $scope.currentLocation
  $scope.submit = ->
    $scope.property.create $scope.hunt
    .then (property) ->
      $scope.location.create property
      $state.transitionTo 'hunts.show', $scope.hunt  #id: property.hunt.id

