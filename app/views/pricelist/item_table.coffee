React = require 'react'
{table, thead, tbody, tr, th, a} = require 'reactionary'

ItemPatternRow = require './item_row_main'
ItemColorRow = require './item_row_sub'

module.exports = React.createClass
  prefetchImg: (e) ->
    id = e.target.id
    item = @props.collection.get(id)
    if item and item._file and item._file.small and item._file.small.path
      img = new Image()
      img.src = item._file.small.path
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

    processItem = (item, rowSpan, isLast) =>
      if rowSpan and rowSpan == 1
        isLast = true
      # Link to detail page.
      if item.detail
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
          isLast: isLast
      else
        rows.push ItemColorRow
          item: item
          key: item.id
          showName: lastName != item.name
          filter: @props.filter
          colorValue: colorValue
          idValue: colorIdValue
          isLast: isLast
      lastName = item.name
      return

    renderPatternItems = (pis) ->
      rowSpan = pis.length
      processItem pis.shift(), rowSpan
      if pis.length
        pis.forEach (pi, index) ->
          last = index+1 == pis.length
          processItem pi, false, last

    # Decide what row view to use.
    @props.collection.forEach (item, i) =>
      # Items of a pattern need to be grouped first.
      renderPitems = item.patternNumber != lastPattern and patternItems.length
      if renderPitems
        renderPatternItems patternItems
        patternItems = []
      if @props.collection.length-1 == i
        patternItems.push item
        renderPatternItems patternItems
        patternItems = []
      else
        patternItems.push item
      lastPattern = item.patternNumber

    ths = []
    # Hide name for trims. Move to model?!?
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

    # Leather is size.
    if @props.filter.category == 'leather'
      ths.push th
        key: 'size'
        className: 'c-size',
          'Approx. Hide Size'
      ths.push th
        key: 'thickness'
        className: 'c-thick',
          'Approx. Thickness'
      ths.push th
        key: 'specSheet'
        className: 'spec-sheet',
          'Spec Sheet'
    # Hide repeat for leather.
    else
      ths.push th
        key: 'repeat'
        className: 'c-repeat',
          'Approx. Repeat'

      # Others have width.
      ths.push th
        key: 'width'
        className: 'c-width',
          'Approx. Width'

    table {},
      thead {},
        tr {}, ths
      tbody {}, rows
