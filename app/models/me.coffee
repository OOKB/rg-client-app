AmpersandModel = require("ampersand-model")
_ = require 'lodash'
r = require 'superagent'
Cookies = require 'cookies-js'

getLocalFavs = ->
  if window.localStorage and favs = window.localStorage['faves']
    #console.log 'get favs'
    return favs.split('/')
  else
    #console.log 'no favs'
    return []

getCustNum = ->
  return Cookies.get('custNum')

module.exports = AmpersandModel.extend

  props:
    favs:
      type: 'array'
      required: true
      default: getLocalFavs
    address: 'string'
    address2: 'string'
    city: 'string'
    customerNumber:
      type: 'string'
      default: getCustNum
    email: 'string'
    phoneNumber: 'string'
    state: 'string'
    zip: 'string'
    username: 'string'
    failedLogins: ['number', true, 0]
    #loggedIn: ['bool', true, false]

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
    loggedIn:
      deps: ['customerNumber']
      fn: ->
        #console.log 'set cookie to '+@customerNumber
        if @customerNumber == null
          Cookies.expire('custNum')
        else
          Cookies.set('custNum', @customerNumber, expires: 86400)
        return if @customerNumber then true else false

  login: (password) ->
    data =
      username: @username
      password: password
    r.post 'https://r_g.cape.io/_login', data, (err, res) =>
      if res.status == 200 and res.body.user
        resp = res.body.user
        #console.log resp
        @set(resp)
        @trigger 'sync', @, resp
      else
        failed = @failedLogins+1
        @set 'failedLogins', failed
        @trigger 'change:failedLogins', @, failed
        console.log 'Failed login number '+failed

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
