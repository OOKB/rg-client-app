Qs = require 'qs'
_ = require 'lodash'
Router = require 'ampersand-router'
itemsFilter = require './models/itemsFilter'

defaultCategory = 'textile'
pageTitle = 'Rogers & Goffigon'

module.exports = Router.extend
  pop: 'ka'
  itemsFilter: itemsFilter
  routes:
    '': 'landing'
    'landing': 'landing'
    'cl': -> @redirectTo('collection')
    'collection': '_collection'
    'collection/:category': '_collection'
    'collection/:category/:pgSize(/:query)/p:page': '_collection'
    'pl': -> @redirectTo('trade/pricelist/'+defaultCategory+'/48/p1')
    'plp': -> @redirectTo('trade/pricelist/passementerie/48/p1')
    'pricelist': -> @redirectTo('trade/pricelist/'+defaultCategory+'/48/p1')
    'trade': 'trade'
    'trade/pricelist': -> @redirectTo('trade/pricelist/'+defaultCategory+'/48/p1')
    'trade/pricelist/:category': 'pricelist'
    'trade/pricelist/:category/:pgSize': 'pricelist'
    'trade/pricelist/:category/:pgSize(/:query)/p:page': 'pricelist'
    'trade/login': 'login'
    'trade/logout': 'logout'
    'trade/account': 'account'
    'trade/summer': 'summer'
    'trade/summer/:category': 'summer'
    'trade/summer/:category/:pgSize(/:query)/p:page': 'summer'
    'trade/projects': 'projects'
    'trade/projects/:projectId': 'projects'
    'detail/:pattern/:id': 'detail'
    'f': -> @redirectTo('favs')
    'favs': 'favs'
    'favs/*items': 'favs'
    '*path': ->
      console.log 'redirect '+@history.fragment
      @redirectTo('cl')

  landing: ->
    @setReactState
      trade: false
      reqAuth: false
      section: 'landing'

  trade: ->
    content = _.find app.content, _id: 'content/trade/index.md'
    #console.log content
    @setReactState
      trade: true
      reqAuth: false
      section: 'trade'
      content: content.content

  summer: (category, pgSize, searchTxt, pageIndex) ->
    unless app.me.loggedIn
      @redirectTo 'trade/login'
      return
    document.title = pageTitle + ' - Summer Sale'
    #console.log 'summer'
    S = _.extend @getQuery(),
      section: 'summer'
      trade: true
      reqAuth: true
      category: category
      pgSize: pgSize
      searchTxt: searchTxt
      pageIndex: pageIndex
      summerSale: true
      patternNumber: null
      color_id: null
    #console.log S
    S = @prepNewState S

    @setReactState S

  # Process raw user input.
  _collection: (category, pgSize, searchTxt, pageIndex) ->
    args = @getQuery()
    if category # Expand shortcut strings to standard machine cat name.
      args.category = @getCategory category
      if pgSize # Comes in as a string.
        args.pgSize = parseInt pgSize
      args.searchTxt = searchTxt or null
      args.pageIndex = parseInt pageIndex
      args.patternNumber = null
    else
      args.category = null
      args.searchTxt = null # searchTxt requries a category.
    @collection args

  collection: (args) ->
    document.title = pageTitle + ' - Collections'
    # Move to filter function
    args.summerSale = false
    if args.category
      args.filterFields = app.itemFilters[args.category]
      if args.pgSize
        app.me[args.category+'Size'] = args.pgSize
      else
        args.pgSize = app.me[args.category+'Size']
    args.section = 'collection'
    args.trade = false
    args.reqAuth = false
    if args.searchTxt # from menu search field or url.
      # Remove stuff we don't want.
      args.searchTxt = @searchTxtParse args.searchTxt
    unless args.pageIndex > 0
      args.pageIndex = 1

    #console.log args
    S = @prepNewState args
    #console.log S
    @setReactState S

  pricelist: (category, pgSize, searchTxt, pageIndex) ->
    unless app.me.loggedIn
      @redirectTo 'trade/login'
      return
    document.title = pageTitle + ' - Pricelist'
    #console.log 'pricelist'
    S = @prepNewState
      reqAuth: true
      trade: true
      section: 'pricelist'
      category: category
      pgSize: pgSize
      searchTxt: searchTxt
      pageIndex: pageIndex
      summerSale: false
      patternNumber: null
    @setReactState S

  detail: (patternNumber, color_id) ->
    #console.log 'detail'
    newSt =
      trade: false
      reqAuth: false
      section: 'detail'
      patternNumber: patternNumber
      hasImage: true
      color_id: color_id
      summerSale: null
    itemsFilter app.items, newSt
    item = app.items.get(newSt.patternNumber+'-'+newSt.color_id)
    if item
      document.title = pageTitle + ' - ' + item.name + ' in ' + item.color
      @setReactState newSt
    else
      #newSt = section: 'item-not-found'
      @redirectTo 'collection/textile/12/'+patternNumber+'/p1'
    return

  favs: (favStr) ->
    unless favStr
      favStr = app.me.favStr
      if favStr
        @redirectTo('favs/'+favStr)
        return
    newSt = @prepNewState
      trade: false
      reqAuth: false
      section: 'favs'
      category: null
      summerSale: null
      ids: favStr.split('/')
    if newSt.ids and newSt.ids.length and app.me.favStr == newSt.ids.join('/')
      newSt.myfavs = true
    else
      newSt.myFavs = false
    @setReactState newSt

  projects: (projectId) ->
    unless app.me.loggedIn
      @redirectTo 'trade/login'
      return
    newSt = @prepNewState
      trade: true
      reqAuth: true
      section: 'projects'
      category: null
      projectId: projectId
      pageIndex: null

    @setReactState newSt

  login: ->
    if app.me.loggedIn
      @redirectTo 'trade/account'
      return
    newSt = @resetState()
    newSt.section = 'login'
    newSt.trade = true
    @setReactState newSt

  # Log the user out.
  logout: ->
    if app.me.loggedIn
      # Should null out all the fields?
      app.me.token = null
      app.me.customerNumber = null
    # Send back to the login page after a logout? or maybe the front page?
    @redirectTo 'trade/login'
    return

  account: ->
    unless app.me.loggedIn
      @redirectTo 'trade/login'
      return
    newSt = @resetState()
    newSt.section = 'account'
    newSt.trade = true
    @setReactState newSt

  # HELPER FUNCTIONS

  pgSizes: (section, hide3up) ->
    switch section
      when 'pricelist'
        [48, 96, 192, 10000]
      when 'favs', 'projects'
        [1000]
      when 'collection', 'summer'
        pgSizes = [3, 12, 24, 48, 96]
        if hide3up
          pgSizes.shift()
        pgSizes
      else [1]

  getCategory: (category) ->
    unless category
      return category
    switch category
      when 't', 'textile' then 'textile'
      when 'p', 'trim', 'passementerie' then 'passementerie'
      when 'l', 'skin', 'hide', 'leather' then 'leather'
      else null

  isItemNumber: (possibleId) ->
    /^(P-|L-)?[0-9]{4,7}-[0-9]{2}[LD]?$/.test(possibleId)

  isPatternNumber: (possiblePattern) ->
    /^(P-|L-)?[0-9]{4,7}$/.test(possiblePattern)

  getQuery: ->
    get = Qs.parse @history.fragment.split('?')[1]
    unless get
      return {}
    q = {}
    if get.id and @isItemNumber(id = get.id.toUpperCase())
      q.id = id
    else if get.pattern
      if @isPatternNumber(patternNumber = get.pattern.toUpperCase())
        q.patternNumber = patternNumber
    if get.order
      q.order = get.order
    if get.color or get.description or get.content or get.type or get.use
      q.selectedFilters =
        color: get.color
        content: get.content
        description: get.description
        type: get.type
        use: get.use
    q

  setQuery: (s) ->
    q = {}
    if s.id
      q.id = s.id
    if s.patternNumber
      q.pattern = s.patternNumber
    if _.size s.selectedFilters
      q = _.merge q, s.selectedFilters
    if s.order and s.order == 'default'
      q.order = s.order
    if _.isEmpty q
      return ''
    else
      return '?'+Qs.stringify(q)

  # Prep state object for collection and pricelist section views.
  prepNewState: (s) ->
    newState = _.cloneDeep s
    newState.category = switch s.category
      when null then null
      when 't' then 'textile'
      when 'textile' then 'textile'
      when 'p' then 'passementerie'
      when 'passementerie' then 'passementerie'
      when 'trim' then 'passementerie'
      when 'l' then 'leather'
      when 'leather' then 'leather'
      when 'skin' then 'leather'
      when 'hide' then 'leather'
      else 'textile'
    newState.categories = [
      active: newState.category == 'textile'
      id: 'textile'
      label: 'Textiles',
        active: newState.category == 'passementerie'
        id: 'passementerie'
        label: 'Passementerie',
          active: newState.category == 'leather'
          id: 'leather'
          label: 'Leather'
    ]
    # Public favs have ids.
    if s.ids
      # Sort public favs in order of itemNumber.
      newState.ids = _.remove(s.ids, @isItemNumber).sort()
      # Why the F would this ever happen?
      if newState.ids.length and not s.ids.length
        s.ids = newState.ids
    # Trade projects
    if s.projectId
      project = app.me.projects.get(s.projectId)
      if project and project.id
        newState.summerSale = null
        newState.ids = _.compact _.pluck(project.entities.models, 'id')
      else
        newState.projectId = null

    # Collection filters.
    newState.filterOptions = switch newState.category
      when 'textile' then ['content', 'color', 'description', 'use']
      when 'passementerie' then ['color', 'description']
      when 'leather' then ['type', 'color']

    unless newState.filterFields
      newState.filterFields = {}

    if s.pageIndex
      newState.pageIndex = parseInt s.pageIndex
      if !newState.pageIndex > 0
        newState.pageIndex = 1
    else
      newState.pageIndex = 1

    ww = newState.windowWidth = window.innerWidth
    isOnTrim = 'passementerie' == newState.category
    newState.isMobile = ww < 768
    if newState.searchTxt
      newState.searchTxt = @searchTxtParse newState.searchTxt
    hide3up = isOnTrim or newState.searchTxt or newState.isMobile
    pgSizes = @pgSizes s.section, hide3up
    if s.section == 'projects'
      newState.pageIndex = null

    newState.pgSize = @closest s.pgSize, pgSizes
    newState.pgSizes = pgSizes
    redirected = @updateURL s, newState

    # filter the items
    if newState.ids or newState.patternNumber or newState.category
      itemsFilter app.items, newState

    if 3 == newState.pgSize
      newState.totalPages = app.items.filtered_length
    else
      newState.totalPages =
        Math.ceil(app.items.filtered_length / newState.pgSize)
    if newState.totalPages and newState.pageIndex > newState.totalPages
      newState.pageIndex = newState.totalPages
      @updateURL s, newState
    #console.log newState
    return newState

  resetState: ->
    searchTxt: ''
    id: null
    trade: false
    reqAuth: false
    patternNumber: null

  searchTxtParse: (searchTxt) ->
    if typeof searchTxt == 'string'
      # Make sure the user input search text is lowercase.
      searchTxt = searchTxt.toLowerCase()
      # Make sure the text string is valid... Regex check.
      searchTxt = searchTxt.replace(/[^a-z0-9-\s]/, '')
      return searchTxt
    else
      return ''

  go: (s) ->
    newUrl = @urlCreate s
    @navigate newUrl, trigger: true

  urlCreate: (s) ->
    # Take care of easy sections first.
    switch s.section
      when 'trade'
        return 'trade'
      when 'detail'
        return 'detail/'+s.patternNumber+'/'+s.color_id
      when 'favs'
        return 'favs/'+s.ids.join('/')
      when 'projects'
        if s.projectId
          return 'trade/projects/'+s.projectId
        else
          return 'trade/projects'
    if s.searchTxt
      searchTxt = s.searchTxt + '/'
    else
      searchTxt = ''
    unless s.category
      if s.trade
        return 'trade/'+s.section
      else
        return s.section
    if s.trade
      urlTxt = 'trade/'+s.section
    else
      urlTxt = s.section
    # Assume it has a category and pgSize.
    urlTxt += '/'+s.category+'/'+s.pgSize+'/'+searchTxt
    urlTxt += 'p' + s.pageIndex + @setQuery(s)
    #console.log urlTxt
    return urlTxt

  updateURL: (oldSt, newSt) ->
    newStateURL = @urlCreate newSt
    oldURL = @urlCreate oldSt
    if newStateURL != oldURL
      #console.log newStateURL + ' - ' + oldURL
      @navigate newStateURL, replace: true
      return true
    else
      return false

  closest: (goal, arr) ->
    if 'all' == goal or 'max' == goal
      return arr[arr.length - 1]
    else
      goal = parseInt(goal)
    # First element in array is the default page size.
    nearest = num = arr[0]
    diff = Math.abs(num - goal)
    if diff == 0
      nearest = num
    else
      for num in arr
        newDiff = Math.abs(num - goal)
        if newDiff < diff
          nearest = num
    return nearest
