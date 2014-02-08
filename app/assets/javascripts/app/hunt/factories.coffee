angular.module 'hunt'

.service '$delay', ($timeout) -> (ms, callback) -> $timeout callback, ms

# TODO maybe not rootScope this? :(
.service 'maps', ($rootScope) ->
  maps =
    locationUpdater: (location) ->
      (event) ->
        $scope.apply ->
          location.longitude = event.latLng.lng()
          location.latitude = event.latLng.lat()

    location: (location) ->
      console.log 'maps.location', location
      new google.maps.LatLng location.latitude, location.longitude

    marker: (location) ->
      marker = new google.maps.Marker
        position: maps.location location
        draggable: true
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

.directive 'map', (maps, $delay) ->
  restrict: 'E'
  scope:
    center: '='
    markers: '='
  link: (scope, elem) ->
    $delay 1000, ->
      scope.map = maps.map elem[0]  # TODO Pass in some attr config here

      markers = _ []  # TODO inject _

      scope.$watch 'center', (newValue) ->
        scope.map.setCenter maps.location newValue

      scope.$watchCollection 'markers', (newValue) ->
        for marker in markers
          marker.setMap null

        for marker in newValue ?= []
          m = maps.marker marker
          m.setMap scope.map
          m.setVisible yes
          markers.push m
          console.log "marker", m

        return

        # TODO un O(n^2) this (Last one even O(n^3)
        ###
        olds ?= []
        news ?= []

        console.log 'markers', news, olds

        for marker in news
          unless marker in olds
            m = maps.marker marker
            m.setMap scope.map
            m.setVisible yes
            markers.push m
            m
            # markers.push maps.marker angular.extend {map: scope.map}, marker

        for marker in olds
          unless marker in news
            delete markers[markers.indexOf marker]

        ###
