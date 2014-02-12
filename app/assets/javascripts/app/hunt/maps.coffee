angular.module 'hunt'

.factory 'geo', ->
  # TODO
  # - Make smart assumptions about position?
  # - Prepopulate through FB?
  return unless navigator.geolocation

  getCurrentPosition: (callback) ->
    navigator.geolocation.getCurrentPosition (position) ->
      callback
        longitude: position.coords.longitude
        latitude: position.coords.latitude

.run ($rootScope, geo) ->
  $rootScope.currentPosition =
    longitude: 0
    latitude: 0
  geo.getCurrentPosition (location) ->
    $rootScope.$apply ->
      $rootScope.currentPosition = location


# TODO maybe not rootScope this? :(
.service 'maps', ($rootScope) ->
  maps =
    locationUpdater: (location) ->
      (event) ->
        $rootScope.apply ->
          location.longitude = event.latLng.lng()
          location.latitude = event.latLng.lat()

    location: (location) ->
      return unless location
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

.directive 'mapHook', (maps) ->
  restrict: 'E'
  scope: true
  link: (scope, elem) ->
    scope.map = maps.map elem[0],
      center: maps.location scope.center
    # TODO Pass in some attr config here

    ###
    scope.$watch 'center', (newValue, oldValue) ->
      return if newValue is oldValue
      scope.map.setCenter maps.location newValue if newValue
    , true
    ###

    google.maps.event.addListener scope.map, 'center_changed', ->
      # TODO getCenter() seems to be very inaccurate
      center = scope.map.getCenter()

      scope.$apply ->
        scope.center.longitude = center.lng()
        scope.center.latitude = center.lat()

.directive 'marker', (maps) ->
  restrict: 'E'
  scope:
    position: '='
    draggable: '='
  link: (scope, elem, attrs) ->
    scope.marker = maps.marker
      draggable: true

    #draggable: scope.draggable

    # TODO This is suuuperugly but works.
    scope.marker.setMap elem.parent().parent().find('map-hook').scope().map

    google.maps.event.addListener scope.marker, 'dragend', (event) ->
      scope.$apply ->
        scope.position.longitude = event.latLng.lng()
        scope.position.latitude = event.latLng.lat()

    scope.$on '$destroy', ->
      scope.marker.setMap null

    scope.$watch 'draggable', (newValue) ->
      console.log 'draggable', newValue
      scope.marker.setDraggable newValue

    scope.$watch 'position', (newValue) ->
      scope.marker.setPosition maps.location newValue if newValue
    , true

