React = require 'react'
{table, thead, tbody, tr, th, a} = require 'reactionary'

ItemPatternRow = require './item_row_main'
ItemColorRow = require './item_row_sub'

module.exports = React.createClass
  prefetchImg: (e) ->
    console.log e.target.id
    # img = new Image()
    # img.src =

  render: ->
    # The processing of rows should probably move up to the container.
    rows = []
    lastPattern = null
    lastName = null
    # Decide what row view to use.
    @props.collection.forEach (item) =>
      if item._file
        colorValue = a
          onMouseOver: @prefetchImg
          id: item.id
          href: '#detail/'+item.patternNumber+'/'+item.color_id,
            item.color
      else
        colorValue = item.color

      if item.patternNumber != lastPattern
        rows.push ItemPatternRow
          item: item
          key: item.id
          filter: @props.filter
          colorValue: colorValue
      else
        row_props =
          item: item
          key: item.id
          showName: lastName != item.name
          filter: @props.filter
          colorValue: colorValue
        rows.push ItemColorRow(row_props)
      lastPattern = item.patternNumber
      lastName = item.name

    ths = []
    # Hide name for trims.
    unless @props.filter.category == 'passementerie'
      ths.push th
        key: 'name'
        className: 'c-name',
          'Name'
    # Show for all.
    ths.push th
      key: 'number'
      className: 'c-number',
        'Item#'
    ths.push th
      key: 'color'
      className: 'c-color',
        'Color'
    ths.push th
      key: 'price'
      className: 'c-price',
        'Net Price'
    ths.push th
      key: 'content'
      className: 'c-content', 'Content'
    # Hide repeat for leather.
    unless @props.filter.category == 'leather'
      ths.push th
        key: 'repeat'
        className: 'c-repeat', 'Repeat'
    # Leather is size.
    if @props.filter.category == 'leather'
      ths.push th
        key: 'size'
        className: 'c-size',
          'Approx. Size'
    # Others are width.
    else
      ths.push th
        key: 'size'
        className: 'c-size',
          'Approx. Width'

    table {},
      thead {},
        tr {}, ths
      tbody {}, rows
