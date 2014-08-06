React = require 'react'
SubCollection = require 'ampersand-subcollection'

ItemsCollection = require './models/items'
FilterableProductTable = require './views/item_container'

items_data = require './models/data'

module.exports =
  blastoff: ->
    self = window.app = @
    # Create our items model collection.
    items = new ItemsCollection(items_data)
    #@items.add items_data
    @items = new SubCollection items
    # This is the main app entry point. For now we call FilterableProductTable
    ## and pass it some items data.
    props =
      collection: @items

    @container = FilterableProductTable(props)
    el = document.getElementById('content')
    React.renderComponent @container, el

# run it
module.exports.blastoff()
