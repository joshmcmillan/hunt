angular.module('hunt', [
  'ui.router'
  'templates'
  'session'
])

angular.module('hunt')

.config ($stateProvider, $urlRouterProvider) ->
  $stateProvider
    .state 'hunt.view.property',
      url: '/property/:propertyID'
      controller: 'PropertyViewCtrl'
      templateUrl: 'hunt/hunt.property.tpl.html'

  $urlRouterProvider.otherwise '/'



