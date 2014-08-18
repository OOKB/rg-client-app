React = require 'react'
{div, ul, li, button, select, option} = require 'reactionary'

Items = require './items'

module.exports = React.createClass
  categoryClick: (e) ->
    @props.setRouterState
      patternNumber: false
      id: false
      category: e.target.value

  pgResize: ->
    @props.setRouterState
      pgSize: @refs.setpgSize.getDOMNode().value

  sizeSelect: ->
    options = []
    pgSizes = @props.initState.pgSizes
    pgSize = @props.initState.pgSize
    pgSizes.forEach (size) ->
      options.push option
        key: size
        value: size,
          size
    li
      key: 'pageselect'
      className: 'pageselect',
        select
          ref: 'setpgSize'
          value: pgSize
          onChange: @pgResize
          type: 'select',
            options

  render: ->
    headerList = []
    titleEl = li
      key: 'title'
      className: 'hug-center on-top',
        button
          className: 'uppercase'
          onClick: @categoryClick
          value: @props.key,
            @props.label

    if @props.active
      itemList = Items @props

      headerList.push li
        key: 'pagecount'
        className: 'pagecount hidden-xs',
          @props.initState.pageIndex + ' / ' + @props.initState.totalPages
      headerList.push @sizeSelect()
      headerList.push titleEl
    else
      itemList = div {}
      headerList.push titleEl

    return div
      className: 'row'
      id: 'collection-row-'+@props.key,
        ul
          className: 'collection-controls',
            headerList
        itemList
