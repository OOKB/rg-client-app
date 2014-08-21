React = require 'react'
{p, div, ul, li, button} = require 'reactionary'
_ = require 'underscore'

Row = require './row'

module.exports = React.createClass

  render: ->
    category = @props.initState.category
    props =
      collection: @props.collection
      initState: @props.initState
      setRouterState: @props.setRouterState
      threeUp: 3 == @props.initState.pgSize
      extraButtons: 'passementerie' == category or 3 == @props.initState.pgSize
    rows = []
    rows.push p
      key: 'intro'
      className: 'text-area',
        'Browse the collection by category below.'
    # Add a row for each collection.
    @props.initState.categories.forEach (cat) ->
      rows.push Row _.extend props,
        key: cat.id
        active: cat.active
        label: cat.label
    div
      id: 'container-collection'
      className: 'collection',
        rows
