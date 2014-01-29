angular.module('hunt')

.config ($stateProvider) ->
  $stateProvider
    .state 'hunts',
      abstract: true
      url: '/hunts'
      views:
        main:
          template: """
            <div ui-view="main"/>
          """
        aside:
          template: """
            <div ui-view="aside"/>
          """

    .state 'hunts.create',
      url: '/new'
      views:
        main:
          controller: 'HuntCreateCtrl'
          templateUrl: 'hunt/hunts/create/main.html'

    .state 'hunts.view',
      url: '/:huntID'
      views:
        main:
          templateUrl: 'hunt/hunts/view/main.html'
          controller: 'HuntViewCtrl'
        aside:
          templateUrl: 'hunt/hunts/view/aside.html'
          controller: 'HuntViewAsideCtrl'

    .state 'hunts.list',
      url: ''
      views:
        main:
          controller: 'HuntListCtrl'
          templateUrl: 'hunt/hunts/list/main.html'
        aside:
          controller: 'HuntListCtrl'
          templateUrl: 'hunt/hunts/list/aside.html'

.run (session) ->
  session.huntsView = 'pipeline'

.controller 'HuntViewCtrl', ($scope, $state, $stateParams, hunt, session) ->
  $scope.hunt = session.hunt = {}

  hunt.api.hunts.view($stateParams.huntID)
    .success (data) ->
      $scope.hunt = session.hunt = data

  if $state.is 'hunts.view'
    $state.transitionTo "hunts.view.#{session.huntsView}", $stateParams

.controller 'HuntViewAsideCtrl', ($scope, session) ->
  $scope.hunt = session.hunt

.controller 'HuntListCtrl', ($scope, session, hunt) ->
  $scope.hunts = []

  hunt.api.hunts.list() #session.user.id)
    .success (data) ->
      $scope.hunts = data

.controller 'HuntCreateCtrl', ($scope, session, hunt) ->
  $scope.hunt = {}

  $scope.submit = ->
    hunt.api.hunts.create $scope.hunt
