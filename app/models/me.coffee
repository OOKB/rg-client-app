AmpersandModel = require("ampersand-model")
_ = require 'lodash'

getLocalFavs = ->
  if window.localStorage and favs = window.localStorage['faves']
    #console.log 'get favs'
    return favs.split('/')
  else
    #console.log 'no favs'
    return []

module.exports = AmpersandModel.extend

  props:
    favs:
      type: 'array'
      required: true
      default: getLocalFavs

  addFav: (id) ->
    favs = @get('favs')
    unless _.contains favs, id
      favs.push id
      @set('favs', favs.sort())
      @trigger 'change:favs', @, favs, id: id, op: 'add'
      return true
    return false

  rmFav: (id) ->
    favs = @get('favs')
    if _.contains favs, id
      favs = _.without favs, id
      @set('favs', favs)
      @trigger 'change:favs', @, favs, id: id, op: 'remove'
      return true
    else
      return false

  hasFav: (id) ->
    favs = @get('favs')
    if _.contains favs, id
      return true
    else
      return false

  derived:
    favStr:
      deps: ['favs']
      fn: ->
        favStr = ''
        if @favs.length
          favStr = @favs.join('/')
        if window.localStorage
          window.localStorage['faves'] = favStr
        return favStr
