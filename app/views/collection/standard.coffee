React = require 'react'
{p, div, ul, li, button} = require 'reactionary'
_ = require 'underscore'

Row = require './row'

module.exports = React.createClass

  render: ->
    props = @props
    categories = @props.initState.categories
    rows = []
    rows.push p
      key: 'intro'
      className: 'text-area',
        'Browse the collection by category below.'
    # Add a row for each collection.
    categories.forEach (cat) ->
      rows.push Row _.extend props,
        key: cat.id
        active: cat.active
        label: cat.label
    div
      id: 'container-collection'
      className: 'collection',
        rows
