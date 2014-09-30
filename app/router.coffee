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
    '': -> @redirectTo('cl')
    'cl': -> @redirectTo('collection')
    'collection': '_collection'
    'collection/:category': '_collection'
    'collection/:category/:pgSize(/:query)/p:page': '_collection'
    'pl': -> @redirectTo('trade/pricelist/'+defaultCategory+'/50/p1')
    'plp': -> @redirectTo('trade/pricelist/passementerie/50/p1')
    'pricelist': -> @redirectTo('trade/pricelist/'+defaultCategory+'/50/p1')
    'trade': 'trade'
    'trade/pricelist': -> @redirectTo('trade/pricelist/'+defaultCategory+'/50/p1')
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
    #console.log 'collection'
    S = _.extend @getQuery(),
      section: 'summer'
      trade: true
      reqAuth: true
      category: category
      pgSize: pgSize
      searchTxt: searchTxt
      pageIndex: pageIndex
      summerSale: true
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
      args.searchTxt = searchTxt
      args.pageIndex = parseInt pageIndex
    else
      args.category = null
    @collection args

  collection: (args) ->
    document.title = pageTitle + ' - Collections'
    # Move to filter function
    args.summerSale = false
    if args.category
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

    #console.log S
    S = @prepNewState args

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
    @setReactState S

  detail: (patternNumber, color_id) ->
    #console.log 'detail'
    newSt =
      trade: false
      reqAuth: false
      section: 'detail'
      patternNumber: patternNumber
      hasDetail: true
      color_id: color_id
      summerSale: null
    itemsFilter app.items, newSt
    item = app.items.get(newSt.patternNumber+'-'+newSt.color_id)
    document.title = pageTitle + ' - ' + item.name + ' in ' + item.color
    @setReactState newSt

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

  # HELER FUNCTIONS

  pgSizes: (section, hide3up) ->
    switch section
      when 'pricelist'
        [50, 100, 10000]
      when 'favs', 'projects' then 1000
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
    if get.color or get.description or get.content or get.type or get.use
      q.selectedFilters =
        color: get.color
        content: get.content
        description: get.description
        type: get.type
        use: get.use
    q

  setQuery: (s) ->
    if s.id or s.patternNumber
      q = id: s.id
    if s.patternNumber
      unless q then q = {}
      q = pattern: s.patternNumber

    if _.size s.selectedFilters
      q = if q then _.merge q, s.selectedFilters else s.selectedFilters

    if q and qString = Qs.stringify(q)
      #console.log q
      return '?' + qString
    else
      return ''

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
      when 'textile' then ['content', 'color', 'description']
      when 'passementerie' then ['color', 'description']
      when 'leather' then ['type', 'color']
    newState.filterFields = {}

    if s.pageIndex
      newState.pageIndex = parseInt s.pageIndex
      if !newState.pageIndex > 0
        newState.pageIndex = 1
    else
      newState.pageIndex = 1

    # Default to HIDE color_id 00.
    newState.omit00 = true

    if 'collection' == s.section or 'summer' == s.section
      newState.hasImage = true
      newState.colorSorted = true
      pgSizes = [3, 12, 24, 48, 96]
      if 'summer' == s.section
        newState.summerSale = true
      if 'passementerie' == newState.category or newState.searchTxt
        pgSizes.shift()
    else if 'pricelist' == s.section
      pgSizes = [50, 100, 10000]
    else if 'favs' == s.section or 'projects' == s.section
      pgSizes = [500]
    else
      pgSizes = [1]

    newState.pgSize = @closest s.pgSize, pgSizes
    newState.pgSizes = pgSizes
    redirected = @updateURL s, newState

    # filter the items
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

  urlCreate: (s) ->
    if s.section == 'trade'
      return 'trade'
    if s.section == 'detail'
      return 'detail/'+s.patternNumber+'/'+s.color_id
    unless s.category
      if s.section == 'favs' and s.ids and s.ids.length
        return s.section+'/'+s.ids.join('/')
      else if s.trade
        url = 'trade/'+s.section
        if s.projectId and 'projects' == s.section
          url += '/'+s.projectId
        return url
      else
        return s.section
    if s.trade
      section = 'trade/'+s.section
    else
      section = s.section
    urlTxt = section+'/'+s.category+'/'+s.pgSize
    if s.searchTxt
      urlTxt += '/' + s.searchTxt
    urlTxt += '/p' + s.pageIndex + @setQuery(s)

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
