AmpersandModel = require 'ampersand-model'
_ = require 'lodash'
r = require 'superagent'
Cookies = require 'cookies-js'

Projects = require './projects'

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
    address: 'string'
    address2: 'string'
    city: 'string'
    customerNumber:
      type: 'string'
    email: 'string'
    phoneNumber: 'string'
    state: 'string'
    zip: 'string'
    username: 'string'
    token:
      type: 'string'
      default: -> Cookies.get('token')
    failedLogins: ['number', true, 0]
    fetchedProjectes: ['bool', true, false]
    showroom: 'object'
    textileSize: ['number', true, 3]
    passementerieSize: ['number', true, 12]
    leatherSize: ['number', true, 3]
    filtersTab: 'string'

  children:
    projects: Projects

  url: ->
    'http://r_g.cape.io/_restricted?access_token='+@token

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

    favUrl:
      deps: ['favStr']
      fn: ->
        'http://staging.rogersandgoffigon.com/app.html#favs/'+@favStr

    loggedIn:
      deps: ['token']
      cache: false
      fn: ->
        if @token
          Cookies.set('token', @token, expires: 4000)
          unless @customerNumber
            @fetch
              success: (model, response, options) =>
                unless @fetchedProjectes
                  # Fetch the project lists too.
                  model.projects.fetch()
                  @fetchedProjectes = true
        else
          Cookies.expire('token')
        return if @token then true else false

  login: (password) ->
    data =
      username: @username
      password: password
    r.post 'https://r_g.cape.io/_login', data, (err, res) =>
      if res.status == 200 and res.body.user
        resp = res.body.user
        resp.token = res.body.token
        console.log resp
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
