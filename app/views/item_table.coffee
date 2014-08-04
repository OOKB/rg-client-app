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
      ths.push th('Name')
    # Show for all.
    ths.push th('Item#')
    ths.push th('Color')
    ths.push th('Net Price')
    ths.push th('Content')
    # Hide repeat for leather.
    unless @props.filter.category == 'leather'
      ths.push th('Repeat')
    # Leather is size.
    if @props.filter.category == 'leather'
      ths.push th('Approx. Size')
    # Others are width.
    else
      ths.push th('Approx. Width')

    table {},
      thead {},
        tr {}, ths
      tbody {}, rows
