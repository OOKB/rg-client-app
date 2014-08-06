Router = require 'ampersand-router'

FilterableProductTable = require './views/item_container'
ItemDetail = require './views/item_detail'

module.exports = Router.extend
  routes:
    '': 'pricelist'
    'pricelist': 'pricelist'
    'detail/:id': 'itemView'

  pricelist: ->
    props = # Pass it some items data.
      collection: app.items
    @trigger 'newPage', FilterableProductTable props

  itemView: (id) ->
    props =
      model: app.items.get id
    @trigger 'newPage', ItemDetail props
