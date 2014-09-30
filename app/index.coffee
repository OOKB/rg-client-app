React = require 'react'
SubCollection = require 'ampersand-subcollection'
_ = require 'lodash'

ItemsCollection = require './models/items'
Router = require './react-router'

ItemsData = require './models/data'
Content = require './models/content'
PatternColors = require './models/pattern_colors'
Me = require './models/me'
Bitly = require './models/bitly_collection'

module.exports =
  blastoff: ->
    window._ = _
    self = window.app = @
    @patternColors = PatternColors
    # Create our items model collection.
    items = new ItemsCollection ItemsData, parse: true
    # Use the subcollection module.
    @items = new SubCollection items
    @itemFilters = {}
    @setCategoryFilterOps()
    @content = Content
    @me = new Me()
    @bitly = new Bitly()
    # Init the React application router.
    el = document.getElementById('react')
    routerComponent = Router {}
    @container = React.renderComponent routerComponent, el

  filterCatProp:
    color: 'colors'
    content: 'content'
    description: 'design_descriptions'
    type: 'name'

  setCategoryFilterOps: ->
    #console.log 'calculate available collection item filters'
    filterOps =
      'textile': ['content', 'color', 'description']
      'passementerie': ['color', 'description']
      'leather': ['type', 'color']
    # Build the search query for the standard collection views.
    config =
      where:
        hasImage: true # Only items with images.
        summerSale: false # No summer sale items.
      filters: []
    config.filters.push (model) -> # Nothing with 00 in color_id
      model.color_id.substring(0, 2) != '00'

    _.forEach filterOps, (ops, cat) =>
      config.where.category = cat
      app.items.configure config, true
      app.itemFilters[cat] = @getFilterFields app.items, ops, cat

  getFilterFields: (items, filterOps) ->
    options = {}
    filterOps.forEach (opt) =>
      f = @filterCatProp[opt]
      options[opt] = _.compact(_.uniq(_.flatten(items.pluck(f)))).sort()
    return options

# run it
module.exports.blastoff()
