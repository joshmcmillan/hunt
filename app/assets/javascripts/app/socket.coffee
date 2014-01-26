angular.module('socket.io')

.service 'io', ->
  connect: (host) ->

    socket = io.connect host

    on: (eventName, callback) ->
      socket.on eventName, ->
        args = arguments
        $rootScope.$apply ->
          callback.apply socket, args
    emit: (eventName, data, callback) ->
      socket.emit eventName, data, ->
        args = arguments
        $rootScope.$apply ->
          callback.apply socket, args
    send: (eventName, data, callback) ->
      socket.send eventName, data, ->
        args = arguments
        $rootScope.$apply ->
          callback.apply socket, args

.factory 'socket', (io) ->
  io.connect()
