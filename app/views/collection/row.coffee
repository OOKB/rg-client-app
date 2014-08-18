React = require 'react'
{div, ul, li, button} = require 'reactionary'

Items = require './items'

module.exports = React.createClass
  categoryClick: (e) ->
    @props.setRouterState
      patternNumber: false
      id: false
      category: e.target.value

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
        className: 'pagecount hidden-xs',
          @props.initState.pageIndex + ' / ' + @props.initState.totalPages
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
