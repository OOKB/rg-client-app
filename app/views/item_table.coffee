React = require 'react'
{table, thead, tbody, tr, th} = require 'reactionary'

ItemPatternRow = require './item_row_main'
ItemColorRow = require './item_row_sub'

module.exports = React.createClass
  render: ->
    rows = []
    lastPattern = null
    @props.items.forEach (item) =>
      id = item.patternNumber+item.color_id
      search_string = (id + item.name + item.color).toLowerCase()
      search_not_found = search_string.indexOf(@props.filterText.toLowerCase()) == -1

      # Skip over items with no string match.
      if search_not_found
        return
      if item.patternNumber != lastPattern
        rows.push ItemPatternRow(item: item, key: id)
      else
        rows.push ItemColorRow(item: item, key: id)
      lastPattern = item.patternNumber

    table {},
      thead {},
        tr {},
          th 'Name'
          th 'Number'
          th 'Color'
          th 'Net Price'
          th 'Size'
      tbody {}, rows
