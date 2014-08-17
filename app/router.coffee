Router = require 'ampersand-router'
itemsFilter = require './models/itemsFilter'

defaultCategory = 'textile'

module.exports = Router.extend
  pop: 'ka'
  itemsFilter: itemsFilter
  routes:
    '': -> @redirectTo('pricelist')
    'cl': -> @redirectTo('collection/'+defaultCategory+'/3')
    'collection': -> @redirectTo('collection/'+defaultCategory+'/3')
    'collection/:category': 'collection'
    'collection/:category/:pgSize': 'collection'
    'collection/:category/:pgSize(/:query)/p:page': 'collection'
    'pl': -> @redirectTo('pricelist/'+defaultCategory+'/50')
    'pricelist': -> @redirectTo('pricelist/'+defaultCategory+'/50')
    'pricelist/:category': 'pricelist'
    'pricelist/:category/:pgSize': 'pricelist'
    'pricelist/:category/:pgSize(/:query)/p:page': 'pricelist'
    'detail/:pattern/:id': 'detail'

  collection: (category, pgSize, searchTxt, pageIndex) ->
    S = @prepNewState 'collection', category, pgSize, searchTxt, pageIndex
    @setReactState S

  pricelist: (category, pgSize, searchTxt, pageIndex) ->
    #console.log 'pricelist'
    S = @prepNewState 'pricelist', category, pgSize, searchTxt, pageIndex
    @setReactState S

  detail: (patternNumber, color_id) ->
    #console.log 'detail'
    newState =
      section: 'detail'
      patternNumber: patternNumber
      hasDetail: true
      color_id: color_id
    itemsFilter app.items, newState
    @setReactState newState

  # Prep state object for collection and pricelist section views.
  prepNewState: (section, category, pgSize, searchTxt, pageIndex) ->
    newState =
      section: section
      searchTxt: @searchTxt searchTxt

    newState.category = switch category
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

    if pageIndex
      newState.pageIndex = parseInt pageIndex
      if !newState.pageIndex > 0
        newState.pageIndex = 1
    else
      newState.pageIndex = 1

    # Default to HIDE color_id 00.
    newState.omit00 = true
    if 'collection' == section
      newState.hasImage = true
      newState.colorSorted = true
      pgSizes = [3, 21, 42, 84]
      if 'passementerie' == newState.category
        favsOnly = false
        pgSizes.shift()
      else
        favsOnly = true
    else if 'pricelist' == section
      pgSizes = [50, 100, 10000]
    else
      pgSizes = [1]

    newState.pgSize = @closest pgSize, pgSizes

    oldState =
      section: section
      category: category
      pgSize: pgSize
      searchTxt: searchTxt
      pageIndex: pageIndex

    redirected = @updateURL oldState, newState

    # filter the items
    itemsFilter app.items, newState
    newState.totalPages =
      Math.ceil(app.items.filtered_length / newState.pgSize)
    if newState.totalPages and newState.pageIndex > newState.totalPages
      newState.pageIndex = newState.totalPages
      @updateURL oldState, newState
    #console.log newState
    return newState

  searchTxt: (search_string) ->
    if typeof search_string == 'string'
      # Make sure the user input search text is lowercase.
      search_string = search_string.toLowerCase()
      # Make sure the text string is valid... Regex check.
      search_string = search_string.replace(/[^a-z0-9-\s]/, '')
      return search_string
    else
      return ''

  urlCreate: (s) ->
    url = s.section+'/'+s.category+'/'+s.pgSize
    if s.searchTxt
      url += '/' + s.searchTxt
    return url+'/p' + s.pageIndex

  updateURL: (oldSt, newSt) ->
    newStateURL = @urlCreate newSt
    oldURL = @urlCreate oldSt
    if newStateURL != oldURL
      #console.log newStateURL + ' - ' + oldURL
      @redirectTo newStateURL
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
