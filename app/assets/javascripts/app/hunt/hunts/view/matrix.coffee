angular.module('hunt')

.config ($stateProvider) ->
  $stateProvider
    .state 'hunts.view.matrix',
      url: '/matrix'
      views:
        main:
          controller: 'MatrixCtrl'
          templateUrl: 'hunt/hunts/view/matrix/main.html'
        aside:
          templateUrl: 'hunt/hunts/view/matrix/aside.html'

.controller 'MatrixCtrl', ($scope, session) ->
  undefined
