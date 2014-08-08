React = require 'react'
{table, thead, tbody, tr, th, a} = require 'reactionary'

ItemPatternRow = require './item_row_main'
ItemColorRow = require './item_row_sub'

module.exports = React.createClass
  prefetchImg: (e) ->
    id = e.target.id
    item = @props.collection.get(id)
    if item._file and item._file.large and item._file.large.path
      img = new Image()
      img.src = item._file.large.path
      console.log 'Preload ' + img.src
    # else
    #   console.log 'no file attr'
    #   console.log item._file

  render: ->
    # The processing of rows should probably move up to the container.
    rows = []
    lastPattern = null
    lastName = null
    patternItems = []

    processItem = (item, rowSpan) =>
      # Link to detail page.
      if item._file and item.category != 'passementerie'
        a_ops =
          onMouseDown: @prefetchImg
          id: item.id
          href: item.detail
        colorValue = a a_ops, item.color
        idValue = a a_ops, item.id
        colorIdValue = a a_ops, item.color_id
      else
        colorValue = item.color
        idValue = item.id
        colorIdValue = item.color_id
      if rowSpan
        rows.push ItemPatternRow
          item: item
          key: item.id
          filter: @props.filter
          colorValue: colorValue
          idValue: idValue
          rowSpan: rowSpan
      else
        rows.push ItemColorRow
          item: item
          key: item.id
          showName: lastName != item.name
          filter: @props.filter
          colorValue: colorValue
          idValue: colorIdValue
      lastName = item.name
      return

    renderPatternItems = (pis) ->
      rowSpan = pis.length
      processItem pis.shift(), rowSpan
      if pis.length
        pis.forEach (pi) ->
          processItem pi, false

    # Decide what row view to use.
    @props.collection.forEach (item, i) =>
      # Items of a pattern need to be grouped first.
      renderPitems = item.patternNumber != lastPattern and patternItems.length
      if renderPitems or @props.collection.length+1 == i
        renderPatternItems patternItems
        patternItems = []
      else
        patternItems.push item
      lastPattern = item.patternNumber

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
