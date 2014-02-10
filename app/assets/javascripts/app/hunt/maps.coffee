angular.module 'hunt'

.factory 'geo', ->
  # TODO
  # - Make smart assumptions about position?
  # - Prepopulate through FB?
  return unless navigator.geolocation

  getCurrentLocation: (callback) ->
    navigator.geolocation.getCurrentPosition (position) ->
      callback
        longitude: position.coords.longitude
        latitude: position.coords.latitude

.run ($rootScope, geo) ->
  geo.getCurrentLocation (location) ->
    $rootScope.$apply ->
      $rootScope.currentLocation = location


# TODO maybe not rootScope this? :(
.service 'maps', ($rootScope) ->
  maps =
    locationUpdater: (location) ->
      (event) ->
        $rootScope.apply ->
          location.longitude = event.latLng.lng()
          location.latitude = event.latLng.lat()

    location: (location) ->
      new google.maps.LatLng parseInt(location.latitude), parseInt(location.longitude)

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
    <map-hook></map-hook>
    <map-controls ng-transclude></map-controls>
  """
  link: (scope, elem) ->
    #map = maps.map elem.find('map-hook')[0]  # TODO Pass in some attr config here
    scope.map = null

    scope.$on 'getMap', ->
      scope.$broadcast 'setMap', scope.map

    scope.$broadcast 'setMap', scope.map


.directive 'mapHook', (maps) ->
  restrict: 'E'
  scope: true
  link: (scope, elem) ->
    scope.map = maps.map elem[0]  # TODO Pass in some attr config here

    scope.$watch 'center', (newValue) ->
      console.log 'map.center', scope.center
      scope.map.setCenter maps.location newValue if newValue
    , true


.directive 'marker', (maps, $timeout) ->
  restrict: 'E'
  scope:
    position: '='
    draggable: '='
  link: (scope, elem, attrs) ->
    console.log scope
    marker = maps.marker draggable: scope.draggable

    # TODO This is suuuperugly but works.
    marker.setMap elem.parent().parent().find('map-hook').scope().map

    scope.$on '$destroy', ->
      marker.setMap null

    scope.$watch 'position', (newValue) ->
      console.log 'marker.position', newValue
      marker.setPosition maps.location newValue if newValue
    , true

    $timeout ->
      scope.$emit 'getMap'
    , 0

    scope.$on 'setMap', (map) ->
      console.log 'setMap', map
      marker.setMap map

    ###
    scope.$watch '$parent.$parent.$$childHead.map', (newValue) ->
      console.log '$parent.$parent'
      console.log 'marker.map', newValue
      marker.setMap newValue

    scope.$watch '$parent.$parent.$parent.$$childHead.map', (newValue) ->
      console.log '$parent.$parent.$parent'
      console.log 'marker.map', newValue
      marker.setMap newValue

    console.log 'init map', scope.$parent.$parent.$$childHead.map || scope.$parent.$parent.$parent.$$childHead.map

    $timeout ->
      marker.setMap scope.$parent.$parent.$$childHead.map || scope.$parent.$parent.$parent.$$childHead.map
    , 2000

    ###

.run ($rootScope) ->
  $rootScope.$on 'getMap', (cb) ->
    console.log '$rootScope.getMap'
