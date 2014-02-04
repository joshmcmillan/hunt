angular.module('hunt')

.config ($stateProvider, resourceRouterProvider) ->
  resourceRouterProvider.mount $stateProvider,
    path: ['hunts']
    views: ['index', 'show', 'new', 'edit']
    templates: ['main', 'aside']

.run (session) ->
  session.huntsView = 'pipeline'


.controller 'HuntsShowCtrl', ($scope, $state, $stateParams, Hunt, session) ->
  $scope.hunt = session.hunt = {}
  Hunt.show($stateParams.huntID).then (hunt) ->
    $scope.hunt = session.hunt = hunt

  if $state.is 'hunts.show'
    $state.transitionTo "hunts.show.#{session.huntsView}", $stateParams


.controller 'HuntsShowAsideCtrl', ($scope, session) ->
  $scope.hunt = session.hunt


.controller 'HuntsIndexMainCtrl', ($scope, Hunt) ->
  $scope.hunts = []
  Hunt.index().then (hunts) ->
    $scope.hunts = hunts


.controller 'HuntsIndexAsideCtrl', ($scope, Hunt) ->
  $scope.hunts = []
  Hunt.index().then (hunts) ->
    $scope.hunts = hunts


.controller 'HuntsNewMainCtrl', ($scope, Hunt) ->
  $scope.hunt = new Hunt
  $scope.submit = ->
    $scope.hunt.create()
    $scope.hunt = new Hunt

.controller 'HuntsNewAsideCtrl', ($scope, Hunt) ->
  undefined

