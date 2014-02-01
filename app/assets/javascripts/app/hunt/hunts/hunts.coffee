angular.module('hunt')

.config ($stateProvider) ->
  $stateProvider
    .state 'hunts',
      abstract: true
      url: '/hunts'
      shows:
        main:
          template: """
            <div ui-show="main"/>
          """
        aside:
          template: """
            <div ui-show="aside"/>
          """

    .state 'hunts.create',
      url: '/new'
      shows:
        main:
          controller: 'HuntCreateCtrl'
          templateUrl: 'hunt/hunts/create/main.html'

    .state 'hunts.show',
      url: '/:huntID'
      shows:
        main:
          templateUrl: 'hunt/hunts/show/main.html'
          controller: 'HuntShowCtrl'
        aside:
          templateUrl: 'hunt/hunts/show/aside.html'
          controller: 'HuntShowAsideCtrl'

    .state 'hunts.index',
      url: ''
      shows:
        main:
          controller: 'HuntIndexCtrl'
          templateUrl: 'hunt/hunts/index/main.html'
        aside:
          controller: 'HuntIndexCtrl'
          templateUrl: 'hunt/hunts/index/aside.html'

.run (session) ->
  session.huntsView = 'pipeline'

.controller 'HuntShowCtrl', ($scope, $state, $stateParams, hunt, session) ->
  $scope.hunt = session.hunt = {}

  hunt.api.hunts.show($stateParams.huntID)
    .success (data) ->
      $scope.hunt = session.hunt = data

  if $state.is 'hunts.show'
    $state.transitionTo "hunts.show.#{session.huntsShow}", $stateParams

.controller 'HuntShowAsideCtrl', ($scope, session) ->
  $scope.hunt = session.hunt

.controller 'HuntIndexCtrl', ($scope, session, hunt) ->
  $scope.hunts = []

  hunt.api.hunts.index() #session.user.id)
    .success (data) ->
      $scope.hunts = data

.controller 'HuntCreateCtrl', ($scope, session, hunt) ->
  $scope.hunt = {}

  $scope.submit = ->
    console.log "HUNT", $scope.hunt
    hunt.api.hunts.create $scope.hunt

