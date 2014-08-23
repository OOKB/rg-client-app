React = require 'react'
SubCollection = require 'ampersand-subcollection'
_ = require 'lodash'

ItemsCollection = require './models/items'
Router = require './react-router'

ItemsData = require './models/data'
Me = require './models/me'

module.exports =
  blastoff: ->
    window._ = _
    self = window.app = @
    # Create our items model collection.
    items = new ItemsCollection ItemsData, parse: true
    # Use the subcollection module.
    @items = new SubCollection items
    @me = new Me()
    # Init the React application router.
    el = document.getElementById('react')
    routerComponent = Router {}
    @container = React.renderComponent routerComponent, el

# run it
module.exports.blastoff()
