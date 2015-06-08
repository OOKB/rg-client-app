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
  session:
    showNotice: ['bool', false, false]
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
    fetchingMe: ['bool', true, false]
    getProjectsOnLogin: ['bool', true, true]
    fetchedProjects: ['bool', true, false]
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
        'http://www.rogersandgoffigon.com/#favs/'+@favStr

    loggedIn:
      deps: ['token', 'customerNumber']
      cache: false
      fn: ->
        if @token
          # Set or extend token.
          Cookies.set('token', @token, expires: 4000)
          if @customerNumber
            #console.log 'We already have customerNumber. Yes, logged in.'
            return true # Yes, logged in.
          else if not app.me.fetchingMe
            app.me.fetchingMe = true
            #console.log 'Need customerNumber. Requesting user data from server.'
            @fetch
              success: (model, response, options) =>
                app.me.fetchingMe = false
                if @getProjectsOnLogin and not @fetchedProjects
                  @fetchProjects()
            return false # No, just initiated login.
          else
            console.log 'Fetching customerNumber already. Waiting for that to return.'
            return false # No, waiting...
          return true

          if @customerNumber and @fetchedProjects
            console.log ''
          else
            console.log 'No customerNumber so we will ask the server for it.'
            @fetch

            return false
        else
          Cookies.expire('token')
          return false

  login: (password) ->
    data =
      username: @username
      password: password
    r.post 'https://r_g.cape.io/_login', data, (err, res) =>
      if res.status == 200 and res.body.user and res.body.user.customerNumber
        resp = res.body.user
        resp.token = res.body.token
        console.log resp
        # Set the customerNumber first.
        @set 'customerNumber', resp.customerNumber
        @set(resp) # Set the rest of the goods.
        @trigger 'sync', @, resp
        #console.log @loggedIn
        @fetchProjects()
      else
        failed = @failedLogins+1
        @set 'failedLogins', failed
        @trigger 'change:failedLogins', @, failed
        console.log 'Failed login number '+failed

  # Fetch the project lists too.
  fetchProjects: ->
    console.log 'Requesting user projects from server.'
    @projects.fetch
      success: (collection, response, options) =>
        console.log 'Projects have been added to user obj.'
        @fetchedProjects = true

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

  updateItemOrder: (id, order) ->
    data =
      id: id
      order: order
    r.put 'https://r_g.cape.io/_api/itemOrder/'+id+'?access_token='+@token, data, (err, res) ->
      console.log res.body
