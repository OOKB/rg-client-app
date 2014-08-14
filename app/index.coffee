React = require 'react'
SubCollection = require 'ampersand-subcollection'

ItemsCollection = require './models/items'
Router = require './react-router'

items_data = require './models/data'

module.exports =
  blastoff: ->
    self = window.app = @
    # Create our items model collection.
    items = new ItemsCollection items_data, parse: true
    # Use the subcollection module.
    @items = new SubCollection items

    # Init the React application router.
    el = document.getElementById('content')
    routerComponent = Router {}
    @container = React.renderComponent routerComponent, el

# run it
module.exports.blastoff()
