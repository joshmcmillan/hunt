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
    $scope.hunts = hunts


.controller 'HuntsIndexAsideCtrl', ($scope) ->
  undefined


.controller 'HuntsNewMainCtrl', ($scope, Hunt, $state) ->
  $scope.markers = []
  $scope.hunt = new Hunt
  $scope.create = ->
    delete $scope.hunt.locations
    console.log 'hunt', $scope.hunt
    $scope.hunt.create()
      .then (hunt) ->
        $state.transitionTo 'hunts.show.dashboard', id: hunt.id
        $scope.hunt = new Hunt


.controller 'HuntsNewAsideCtrl', ($scope, Hunt) ->
  undefined

