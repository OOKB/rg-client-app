React = require 'react'
SubCollection = require 'ampersand-subcollection'

ItemsCollection = require './models/items'
Router = require './router'

items_data = require './models/data'

module.exports =
  blastoff: ->
    self = window.app = @
    # Create our items model collection.
    items = new ItemsCollection(items_data)
    #@items.add items_data
    @items = new SubCollection items

    # Init URL handler and history tracker.
    @router = new Router()

    el = document.getElementById('content')
    @router.on 'newPage', (container) ->
      @container = container
      React.renderComponent @container, el
    @router.history.start()

# run it
module.exports.blastoff()
