###

Desired usage:

<map id="my-map"></map>

- Manage arrays of markers/areas
- Zoom to contain markers/areas
- Control to add markers/areas

###



angular.module('google.maps', [])

.factory 'maps', ->
  google.maps

.service 'google', ->
  {}

.directive('googleMapsAsync', ['$window', ($window) ->
  restrict: 'EA'
  link: (scope, elem) ->
    id = 'google-maps-jssdk'

    $window.googleMapsAsyncInit = ->
      console.log "GOOGLE MAPS LOADED"

    unless $('#'+id).length
      $('<script>',
        id: id
        src: "//maps.googleapis.com/maps/api/js?sensor=false&callback=googleMapsAsyncInit"
      ).appendTo elem
])

.service 'maps', (google) ->
  return google.maps

  # Holds all google maps directive objects by id
  maps = {}

  add: (map) ->
    map.addMarker = (options) ->
      options ||= {}
      options.map = map
      marker = new maps.Marker options
      maps.markers.push marker
      marker

  createMap: (elem, options) ->
    options ||= {}
    options.zoom ||= 15
    options.mapTypeId ||= google.maps.MapTypeId.ROADMAP

    new google.maps.Map elem, options

  createMarker: (map, options) ->
    new google.maps.Marker map: map

.directive('googleMap', ['$timeout', ($timeout) ->
  restrict: 'E'
  scope:
    area: '='
  link: (scope, elem, attr) ->
    $timeout((->
      scope.map = new google.maps.Map(elem[0],
        zoom: 13
        mapTypeId: google.maps.MapTypeId.ROADMAP
        draggableCursor: 'crosshair'
      )

      #map.$scope = $scope
      #maps.hash[attr.id] = $scope.map if attr.id

      scope.marker = new google.maps.Marker
        map: scope.map
        draggable: true

      scope.circle = new google.maps.Circle
        map: scope.map
        fillColor: 'green'
        fillOpacity: 0.25
        strokeOpacity: 0

      updateMarker = (event) ->
        console.log "MAP EVENT", event
        scope.$apply ->
          scope.area.longitude = event.latLng.lng()
          scope.area.latitude = event.latLng.lat()

      google.maps.event.addListener scope.map, 'click', updateMarker
      google.maps.event.addListener scope.marker, 'dragend', updateMarker

      scope.$watch 'area', (area) ->
        console.log 'area', area

        return unless area

        location = new google.maps.LatLng area.latitude, area.longitude
        scope.map.setCenter location
        scope.marker.setPosition location

        if area.radius
          scope.circle.setOptions
            center: location
            radius: area.radius * 500
      , true

    ), 2000)
])

