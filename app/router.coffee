Router = require 'ampersand-router'

FilterableProductTable = require './views/pricelist/item_container'
ItemDetail = require './views/detail/container'
itemsFilter = require './models/itemsFilter'
Threeup = require './views/collection/3up'

defaultCategory = 'textile'

module.exports = Router.extend
  routes:
    '': -> @redirectTo('pricelist')
    'collection': -> @redirectTo('collection/'+defaultCategory)
    'collection/:category': 'collection'
    'collection/:category(/:query)/p:page': 'collection'
    'pricelist': -> @redirectTo('pricelist/'+defaultCategory)
    'pricelist/:category': 'pricelist'
    'pricelist/:category(/:query)/p:page': 'pricelist'
    'detail/:pattern/:id': 'itemView'

  collection: (category, searchTxt, pageIndex) ->
    if pageIndex
      pageIndex = parseInt pageIndex
    else
      pageIndex = 0
    newState =
      category: category
      searchTxt: searchTxt
      pageIndex: pageIndex
      pageSize: 3 # Should this be in the url?

    itemsFilter app.items, newState

    # if 'passementerie' == newState.category
    #   component = Trim
    #     collection: app.items
    # else
    component = Threeup
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
