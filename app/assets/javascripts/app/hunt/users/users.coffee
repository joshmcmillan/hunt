angular.module('hunt')

.config ($stateProvider) ->
  $stateProvider
    .state 'users',
      abstract: true
      url: '/users'
      template: """
        <ui-view/>
      """

    .state 'users.view',
      url: '/:userID'
      controller: 'UserViewCtrl'
      templateUrl: 'hunt/users/view.html'

.controller 'UsersViewCtrl', ($scope, $stateParams, hunt) ->
  $scope.user = {}

  hunt.users.view($stateParams.userID)
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

