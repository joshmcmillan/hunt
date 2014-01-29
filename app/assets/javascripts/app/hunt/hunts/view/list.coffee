angular.module('hunt')

.config ($stateProvider) ->
  $stateProvider
    .state 'hunts.view.list',
      url: '/list'
      views:
        main:
          controller: 'ListCtrl'
          templateUrl: 'hunt/hunts/view/list/main.html'
        aside:
          templateUrl: 'hunt/hunts/view/list/aside.html'

.controller 'ListCtrl', ($scope, session) ->
  undefined

