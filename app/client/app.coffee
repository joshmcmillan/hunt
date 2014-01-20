angular.module('hunt', [
  'ui-state'
])

angular.config ($stateProvider, $urlRouterProvider) ->
  $stateProvider
    .state 'login'
      url: '/login'
      views:
        main:
          controller: 'LoginCtrl'
          templateUrl: 'hunt/login.tpl.html'

    .state 'hunt.list'
      url: '/hunts'
      views:
        main:
          controller: 'HuntListCtrl'
          templateUrl: 'hunt/hunt.list.tpl.html'

    .state 'hunt.view'
      url: '/hunts/:huntID'
      views:
        main:
          controller: 'HuntViewCtrl'
          templateUrl: 'hunt/hunt.view.tpl.html'

    .state 'hunt.view.property'
      url: '/property/:propertyID'
      views:
        main:
          controller: 'PropertyViewCtrl'
          templateUrl: 'hunt/hunt.property.tpl.html'

  $urlRouterProvider.otherwise '/'

angular.controller 'HuntListCtrl' ($scope, session, hunt) ->
  $scope.hunts = []

  hunt.hunts.list(session.user.id)
    .success (data) ->
      $scope.properties = data

angular.controller 'HuntViewCtrl', ($scope, $stateParams, hunt) ->
  $scope.hunt = {}

  hunt.hunts.view($stateParams.huntID)
    .success (data) ->
      $scope.hunt = data

angular.controller 'PropertyListCtrl', ($scope, hunt) ->
  $scope.properties = []

  hunt.properties.list()
    .success (data) ->
      $scope.properties = data


angular.controller 'PropertyViewCtrl', ($scope, $stateParams, hunt) ->
  $scope.property = {}

  hunt.properties.view($stateParams.propertyID)
    .success (data) ->
      $scope.property = data


angular.controller 'UserCtrl', ($scope) ->
  null



