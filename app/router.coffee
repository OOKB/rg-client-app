Router = require 'ampersand-router'

FilterableProductTable = require './views/pricelist/item_container'
ItemDetail = require './views/detail/container'
itemsFilter = require './models/itemsFilter'
Collection = require './views/collection/items'

defaultCategory = 'textile'

closest = (goal, arr) ->
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

module.exports = Router.extend
  routes:
    '': -> @redirectTo('pricelist')
    'collection': -> @redirectTo('collection/'+defaultCategory+'/3')
    'collection/:category': 'collection'
    'collection/:category/:pg(/:query)/p:page': 'collection'
    'pricelist': -> @redirectTo('pricelist/'+defaultCategory)
    'pricelist/:category': 'pricelist'
    'pricelist/:category(/:query)/p:page': 'pricelist'
    'detail/:pattern/:id': 'itemView'

  collection: (category, pgSize, searchTxt, pageIndex) ->
    if pageIndex
      pageIndex = parseInt pageIndex
    else
      pageIndex = 0
    if pgSize
      pgSize = closest parseInt(pgSize), [3, 21, 42, 84]
    else
      pgSize = 3

    newState =
      category: category
      searchTxt: searchTxt
      pageIndex: pageIndex
      pageSize: pgSize
      hasImage: true

    itemsFilter app.items, newState

    #console.log newState
    component = Collection
      collection: app.items

    @trigger 'newPage', component

  pricelist: (category, searchTxt, pageIndex) ->
    if pageIndex
      pageIndex = parseInt pageIndex
    else
      pageIndex = 0

    unless searchTxt
      searchTxt = ''

    # Filter the items on initial render.
    newState =
      category: category
      searchTxt: searchTxt
      pageIndex: pageIndex
      pageSize: 50 # Should this be in the url?

    itemsFilter app.items, newState

    totalPages = Math.ceil(app.items.filtered_length / 50)-1
    if pageIndex and pageIndex > totalPages
      #console.log 'too big'
      destination = 'pricelist/'+category+'/'
      if searchTxt
        destination += searchTxt +'/'
      #console.log destination+'p'+totalPages
      @redirectTo destination+'p'+(totalPages-1)
      return

    component = FilterableProductTable
      collection: app.items
      initState: newState

    @trigger 'newPage', component

  itemView: (patternNumber, color_id) ->
    config =
      where:
        patternNumber: patternNumber
      filter: (model) ->
        model._file

    app.items.configure config, true
    props =
      initColor: color_id
      collection: app.items
      patternNumber: patternNumber
    @trigger 'newPage', ItemDetail props
