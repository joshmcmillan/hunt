angular.module('hunt', [
  'ui.router'
  'templates'
])

angular.module('hunt')

.config ($stateProvider, $urlRouterProvider) ->
  $stateProvider
    .state 'login',
      url: '/login'
      controller: 'LoginCtrl'
      templateUrl: 'session/login.html'

    .state 'hunt.view.property',
      url: '/property/:propertyID'
      controller: 'PropertyViewCtrl'
      templateUrl: 'hunt/hunt.property.tpl.html'

  $urlRouterProvider.otherwise '/'

.controller 'HuntListCtrl', ($scope, session, hunt) ->
  $scope.hunts = []

  hunt.hunts.list(session.user.id)
    .success (data) ->
      $scope.properties = data

.controller 'HuntViewCtrl', ($scope, $stateParams, hunt) ->
  $scope.hunt = {}

  hunt.hunts.view($stateParams.huntID)
    .success (data) ->
      $scope.hunt = data

.controller 'PropertyListCtrl', ($scope, hunt) ->
  $scope.properties = []

  hunt.properties.list()
    .success (data) ->
      $scope.properties = data

.controller 'PropertyViewCtrl', ($scope, $stateParams, hunt) ->
  $scope.property = {}

  hunt.properties.view($stateParams.propertyID)
    .success (data) ->
      $scope.property = data

.controller 'LoginCtrl', ($scope) ->
  console.log "LoginCtrl"



