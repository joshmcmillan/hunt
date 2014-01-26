angular.module('hunt')

.config ($stateProvider, $urlRouterProvider) ->
  $stateProvider
    .state 'hunt',
      abstract: true
      url: '/hunts'
      template: """
        <ui-view/>
      """

    .state 'hunt.view',
      abstract: true
      url: '/:huntID'
      controller: 'HuntViewCtrl'
      template: """
        <button ui-sref="hunt.view.pipeline">Pipeline</button>
        <button ui-sref="hunt.view.map">Map</button>

        <ui-view/>
      """

    .state 'hunt.list',
      url: ''
      controller: 'HuntViewCtrl'
      templateUrl: 'hunt/list.html'

.controller 'HuntViewCtrl', ($scope, $stateParams, hunt) ->
  $scope.hunt = {}

  hunt.hunts.view($stateParams.huntID)
    .success (data) ->
      $scope.hunt = data

.controller 'HuntListCtrl', ($scope, session, hunt) ->
  $scope.hunts = []

  hunt.hunts.list(session.user.id)
    .success (data) ->
      $scope.hunts = data

