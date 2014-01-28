angular.module('hunt')

.config ($stateProvider) ->
  $stateProvider
    .state 'users',
      abstract: true
      url: '/users'
      views:
        main:
          template: """
            <div ui-view="main"/>
          """
        aside:
          template: """
          <div ui-view="aside"/>
        """

    .state 'users.list',
      url: ''
      views:
        main:
          controller: 'UserViewCtrl'
          templateUrl: 'hunt/users/list.html'

    .state 'users.view',
      url: '/:userID'
      views:
        main:
          controller: 'UserViewCtrl'
          templateUrl: 'hunt/users/view.html'

.controller 'UserViewCtrl', ($scope, $stateParams, hunt) ->
  $scope.user = {}

  hunt.api.users.view($stateParams.userID)
    .success (data) ->
      $scope.user = data

.directive 'userCard', ->
  restrict: 'E'
  scope:
    user: '='
  templateUrl: "hunt/users/card.html"

.directive 'userList', ->
  restrict: 'E'
  scope:
    users: '='
  templateUrl: 'hunt/users/list.html'

