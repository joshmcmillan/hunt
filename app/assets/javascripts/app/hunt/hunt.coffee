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
      url: '/:huntID'
      controller: 'HuntViewCtrl'
      template: """
        <h1>{{hunt.name}}</h1>

        <button ui-sref="hunt.view.pipeline">Pipeline</button>
        <button ui-sref="hunt.view.map">Map</button>

        <ui-view/>
      """

    .state 'hunt.list',
      url: ''
      controller: 'HuntListCtrl'
      templateUrl: 'hunt/list.html'

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

