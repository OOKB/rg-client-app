Router = require 'ampersand-router'

FilterableProductTable = require './views/pricelist/item_container'
ItemDetail = require './views/detail/container'

module.exports = Router.extend
  routes:
    '': 'pricelist'
    'pricelist': 'pricelist'
    'detail/:pattern/:id': 'itemView'

  pricelist: ->
    props = # Pass it some items data.
      collection: app.items
    @trigger 'newPage', FilterableProductTable props

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
