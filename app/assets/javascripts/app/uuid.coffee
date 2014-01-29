angular.module 'uuid', []

.factory 'uuid', ->
  hex8 = (dashed) ->
    digits = "#{Math.random().toString(16)}000000000".substr(2,8)
    if dashed
      "-#{digits.substr(0,4)}-#{digits.substr(4,4)}"
    else
      digits

  new: ->
    hex8() + hex8(true) + hex8(true) + hex8()

  empty: ->
    '00000000-0000-0000-0000-000000000000'

