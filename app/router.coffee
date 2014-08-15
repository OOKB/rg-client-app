Router = require 'ampersand-router'
itemsFilter = require './models/itemsFilter'

defaultCategory = 'textile'

module.exports = Router.extend
  pop: 'ka'
  itemsFilter: itemsFilter
  routes:
    '': -> @redirectTo('pricelist')
    'collection': -> @redirectTo('collection/'+defaultCategory+'/3')
    'collection/:category': 'collection'
    'collection/:category/:pgSize': 'collection'
    'collection/:category/:pgSize(/:query)/p:page': 'collection'
    'pricelist': -> @redirectTo('pricelist/'+defaultCategory+'/50')
    'pricelist/:category/:pgSize': 'pricelist'
    'pricelist/:category/:pgSize(/:query)/p:page': 'pricelist'
    'detail/:pattern/:id': 'itemView'

  collection: (category, pgSize, searchTxt, pageIndex) ->
    S = @prepNewState 'collection', category, pgSize, searchTxt, pageIndex
    @setReactState S

  pricelist: (category, pgSize, searchTxt, pageIndex) ->
    S = @prepNewState 'pricelist', category, pgSize, searchTxt, pageIndex
    @setReactState S

  prepNewState: (section, category, pgSize, searchTxt, pageIndex) ->
    newState =
      section: section
      searchTxt: searchTxt

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
    else
      newState.pageIndex = 0

    newState.omit00 = false # Default to showing color_id 00.
    if 'collection' == section
      pgSizes = [3, 21, 42, 84]
      if 'passementerie' == newState.category
        favsOnly = false
        pgSizes.shift()
      else
        favsOnly = true
    else if 'pricelist' == section
      newState.omit00 = true # Hide color_id 00.
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
    if redirected
      return false
    else
      # filter the items
      itemsFilter app.items, newState
      newState.totalPages =
        Math.abs(Math.ceil(app.items.filtered_length / newState.pgSize) - 1)
      if newState.pageIndex > newState.totalPages
        newState.pageIndex = newState.totalPages
        @updateURL oldState, newState
      #console.log newState
      return newState

  urlCreate: (s) ->
    url = s.section+'/'+s.category+'/'+s.pgSize
    if s.searchTxt
      url += '/' + s.searchTxt
    return url+'/p' + s.pageIndex

  updateURL: (oldSt, newSt) ->
    newStateURL = @urlCreate newSt
    oldURL = @urlCreate oldSt
    if newStateURL != oldURL
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

#

# pricelist: (category, searchTxt, pageIndex) ->
#   if pageIndex
#     pageIndex = parseInt pageIndex
#   else
#     pageIndex = 0
#
#   unless searchTxt
#     searchTxt = ''
#
#   # Filter the items on initial render.
#   newState =
#     category: category
#     searchTxt: searchTxt
#     pageIndex: pageIndex
#     pageSize: 50 # Should this be in the url?
#
#   itemsFilter app.items, newState
#
#   totalPages = Math.ceil(app.items.filtered_length / 50)-1
#   if pageIndex and pageIndex > totalPages
#     #console.log 'too big'
#     destination = 'pricelist/'+category+'/'
#     if searchTxt
#       destination += searchTxt +'/'
#     #console.log destination+'p'+totalPages
#     @redirectTo destination+'p'+(totalPages-1)
#     return
#
#
# itemView: (patternNumber, color_id) ->
#   config =
#     where:
#       patternNumber: patternNumber
#     filter: (model) ->
#       model._file
#
#   app.items.configure config, true
#   props =
#     initColor: color_id
#     collection: app.items
#     patternNumber: patternNumber
#   @trigger 'newPage', ItemDetail props
