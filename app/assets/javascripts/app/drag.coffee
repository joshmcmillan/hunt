angular.module('drag-n-drop', [
  'uuid'
])

.directive 'draggable', ($rootScope, uuid) ->
  restrict: 'A'
  link: (scope, el) ->
    angular.element(el).attr 'draggable', 'true'

    unless id = angular.element(el).attr 'id'
      id = uuid.new()
      angular.element(el).attr 'id', id

    el.bind 'dragstart', (e) ->
      e.dataTransfer.setData 'text', id
      $rootScope.$emit 'DRAG-START'

    el.bind 'dragend', (e) ->
      $rootScope.$emit 'DRAG-END'


.directive 'dropTarget', ($rootScope, uuid) ->
  restrict: 'A'
  scope:
    onDrop: '&'
  link: (scope, el) ->
    unless id = angular.element(el).attr 'id'
      id = uuid.new()
      angular.element(el).attr 'id', id

    el.bind 'dragover', (e) ->
      # Necessary. Allows us to drop.
      e.preventDefault?()
      e.stopPropagation?()
      e.dataTransfer.dropEffect = 'move'
      false

    el.bind 'dragenter', (e) ->
      angular.element(e.target).addClass 'drag-over'

    el.bind 'dragleave', (e) ->
      angular.element(e.target).removeClass 'drag-over'

    el.bind 'drop', (e) ->
      # Necessary. Allows us to drop.
      e.preventDefault?()
      e.stopPropogation?()

      data = e.dataTransfer.getData 'text'
      dest = document.getElementById id
      src = document.getElementById data

      scope.onDrop dragEl: src, dropEl: dest

    $rootScope.$on 'DRAG-START', ->
      el = document.getElementById id
      el = angular.element el
      el.addClass 'drag-target'

    $rootScope.$on 'DRAG-END', ->
      el = document.getElementById id
      el = angular.element el
      el.removeClass 'drag-target'
      el.removeClass 'drag-over'

