React = require 'react'
{table, thead, tbody, tr, th} = require 'reactionary'

ItemPatternRow = require './item_row_main'
ItemColorRow = require './item_row_sub'

module.exports = React.createClass
  render: ->
    # The processing of rows should probably move up to the container.
    rows = []
    lastPattern = null
    lastName = null
    # Decide what row view to use.
    @props.collection.forEach (item) =>
      if item.patternNumber != lastPattern
        rows.push ItemPatternRow(item: item, key: item.id, filter: @props.filter)
      else
        row_props =
          item: item
          key: item.id
          showName: lastName != item.name
          filter: @props.filter
        rows.push ItemColorRow(row_props)
      lastPattern = item.patternNumber
      lastName = item.name

    ths = []
    # Hide name for trims.
    unless @props.filter.category == 'passementerie'
      ths.push th(className: 'c-name', 'Name')
    # Show for all.
    ths.push th(className: 'c-number', 'Item#')
    ths.push th(className: 'c-color', 'Color')
    ths.push th(className: 'c-price', 'Net Price')
    ths.push th(className: 'c-content', 'Content')
    # Hide repeat for leather.
    unless @props.filter.category == 'leather'
      ths.push th(className: 'c-repeat', 'Repeat')
    # Leather is size.
    if @props.filter.category == 'leather'
      ths.push th(className: 'c-size', 'Approx. Size')
    # Others are width.
    else
      ths.push th(className: 'c-size', 'Approx. Width')

    table {},
      thead {},
        tr {}, ths
      tbody {}, rows
