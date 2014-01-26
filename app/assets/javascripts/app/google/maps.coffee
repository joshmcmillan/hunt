###

Desired usage:

<map id="my-map"></map>

###



angular.module('google.maps', [])

.factory 'maps', (google) ->
  google.maps

.directive('googleMapsAsync', ['$window', 'maps', ($window, maps) ->
  restrict: 'EA'
  link: (scope, elem) ->
    id = 'google-maps-jssdk'

    $window.googleMapsAsyncInit = ->
      google.maps = maps

      maps.init $window.google.maps
      maps.execute()

    unless $('#'+id).length
      elem.append angular.element '<script>',
        id: id
        src: "//maps.googleapis.com/maps/api/js?sensor=false&callback=googleMapsAsyncInit"
])

.service 'mapsHash', ->
  # Holds all google maps directive objects by id
  maps = {}

  add: (map) ->
    map.addMarker = (options) ->
      options ||= {}
      options.map = map
      marker = new maps.Marker options
      maps.markers.push marker
      marker

.directive('google-map', ['googleMaps', (maps) ->
  restrict: 'E'
  link: (scope, elem, attr) ->
    $timeout((->
      $scope.map = new maps.Map($elem[0],
        zoom: 15
        mapTypeId: maps.MapTypeId.ROADMAP
      )

      #map.$scope = $scope
      #maps.hash[attr.id] = $scope.map if attr.id

      $scope.marker = new maps.Marker map: $scope.map

      $scope.$watch 'center', (newVal) ->
        $scope.map.setCenter new maps.LatLng newVal.lat, newVal.lng if newVal
        $scope.marker.setCenter new maps.LatLng newVal.lat, newVal.lng if newVal

    ), 1000)
])
