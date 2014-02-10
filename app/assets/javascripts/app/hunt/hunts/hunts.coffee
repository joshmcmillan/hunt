angular.module('hunt')

.config ($stateProvider, resourceRouterProvider) ->
  resourceRouterProvider.mount $stateProvider,
    path: ['hunts']
    views: ['index', 'show', 'new', 'edit']
    templates: ['main', 'aside']


.run (session) ->
  session.huntsView = 'dashboard'


.controller 'HuntsShowMainCtrl', ($scope, $state, $stateParams, Hunt, session) ->
  $scope.hunt = session.hunt = {}
  Hunt.show $stateParams.id
  .then (hunt) ->
    $scope.hunt = session.hunt = hunt

  if $state.is 'hunts.show'
    $state.transitionTo "hunts.show.#{session.huntsView}", $stateParams


.controller 'HuntsShowAsideCtrl', ($scope, session) ->
  $scope.hunt = session.hunt


.controller 'HuntsIndexMainCtrl', ($scope, Hunt) ->
  $scope.hunts = []
  Hunt.index()
  .then (hunts) ->
    console.log 'hunts', hunts
    $scope.hunts = hunts


.controller 'HuntsIndexAsideCtrl', ($scope) ->
  undefined


.controller 'HuntsNewMainCtrl', ($scope, Hunt, $state) ->
  # TODO
  # - Make smart assumptions about position?
  # - Prepopulate through FB?
  $scope.currentPosition =
    longitude: 0
    latitude: 0

  $scope.markers = [
  ]

  if navigator.geolocation
    navigator.geolocation.getCurrentPosition (position) ->
      $scope.$apply ->
        $scope.currentPosition = position.coords
        $scope.hunt.longitude = position.coords.longitude
        $scope.hunt.latitude = position.coords.latitude
        $scope.markers.push position.coords

  $scope.targetCostUnitOptions = [
    'weekly'
    'monthly'
  ]
  $scope.hunt = new Hunt
  $scope.create = ->
    $scope.hunt.create()
      .then (hunt) ->
        $state.transitionTo 'hunts.show.dashboard', id: hunt.id
        $scope.hunt = new Hunt


.controller 'HuntsNewAsideCtrl', ($scope, Hunt) ->
  undefined

