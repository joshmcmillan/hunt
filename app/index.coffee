process.exports.NODE_ENV = process.env.NODE_ENV or 'development'

module.exports = ->
  while true
    console.log 'woop'