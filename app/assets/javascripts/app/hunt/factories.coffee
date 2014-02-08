angular.module 'hunt'

# TODO maybe not rootScope this? :(
.service 'maps', ($rootScope) ->
  maps =
    locationUpdater: (location) ->
      (event) ->
        $rootScope.apply ->
          location.longitude = event.latLng.lng()
          location.latitude = event.latLng.lat()

    location: (location) ->
      new google.maps.LatLng location.latitude, location.longitude

    marker: (options) ->
      options ?= {}
      options.draggable ?= true
      #options.position ?= maps.location x, y
      marker = new google.maps.Marker options
      google.maps.event.addListener marker, 'dragend', maps.locationUpdater location
      marker

    area: (location, options) ->
      options ?= {}
      options.fillColor ?= 'green'
      options.fillOpacity ?= 0.25
      options.strokeOpacity ?= 0
      options.center = maps.location location
      options.radius = maps.location.distance
      new google.maps.Circle options

    map: (elem, options) ->
      options ?= {}
      options.zoom ?= 13
      options.mapTypeId ?= google.maps.MapTypeId.ROADMAP
      new google.maps.Map elem, options

.directive 'map', (maps) ->
  restrict: 'E'
  scope:
    center: '='
  transclude: true
  template: """
    <map-hook />
    <map-controls ng-transclude />
  """
  link: (scope, elem) ->

    scope.test =
      map: maps.map elem.find('map-hook')[0]  # TODO Pass in some attr config here

    scope.$watch 'center', (newValue) ->
      console.log 'map.center', scope.center
      scope.test.map.setCenter maps.location newValue if newValue

.directive 'mapHook', (maps) ->
  restrict: 'E'

.directive 'marker', (maps) ->
  restrict: 'E'
  scope:
    map: '='
    position: '='
  link: (scope, elem, attrs, mapCtrl) ->
    marker = maps.marker()

    scope.$on '$destroy', ->
      marker.setMap null

    scope.$watch 'position', (newValue) ->
      console.log 'marker.position', newValue
      marker.setPosition maps.location newValue if newValue

    scope.$watch 'map', (newValue) ->
      console.log 'marker.map', newValue, scope
      marker.setMap newValue

    marker.setMap scope.map
