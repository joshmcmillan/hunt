angular.module 'geolocation', []

.service 'geolocation', ->
  navigator.geolocation if navigator.geolocation

