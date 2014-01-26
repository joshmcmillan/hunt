angular.module('hunt')

.config ($stateProvider) ->
  $stateProvider
    .state 'hunts',
      abstract: true
      url: '/hunts'
      template: """
        <ui-view/>
      """

    .state 'hunts.create',
      url: '/new'
      controller: 'HuntCreateCtrl'
      templateUrl: 'hunt/hunts/create.html'

    .state 'hunts.view',
      url: '/:huntID'
      controller: 'HuntViewCtrl'
      templateUrl: 'hunt/hunts/view.html'

    .state 'hunts.list',
      url: ''
      controller: 'HuntListCtrl'
      templateUrl: 'hunt/hunts/list.html'

.controller 'HuntViewCtrl', ($scope, $stateParams, hunt) ->
  $scope.hunt = {}

  hunt.hunts.view($stateParams.huntID)
    .success (data) ->
      $scope.hunt = data

.controller 'HuntListCtrl', ($scope, session, hunt) ->
  $scope.hunts = []

  hunt.hunts.list() #session.user.id)
    .success (data) ->
      $scope.hunts = data

.controller 'HuntCreateCtrl', ($scope, session, hunt) ->
  $scope.hunt = {}

  $scope.submit = ->
    hunt.hunts.create $scope.hunt
