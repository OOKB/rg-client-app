React = require 'react'
{div, p, ul, li, button, img, i} = require 'reactionary'

module.exports = React.createClass
  getInitialState: ->
    buttonsFor: @props.buttonsForInit

  setButtonsFor: (e) ->
    @setState buttonsFor: e.target.id

  colorsClick: (e) ->
    if 'passementerie' == @props.initState.category
      if @props.initState.patternNumber
        @props.setRouterState
          patternNumber: false
      else
        @props.setRouterState
          patternNumber: e.target.value

  render: ->
    list = []
    extraButtons = 'passementerie' == @props.initState.category or 3 == @props.initState.pgSize
    # List
    @props.collection.forEach (item, index) =>
      if @state.buttonsFor == item.id
        buttons = []
        if extraButtons
          buttons.push button
            key: 'colors'
            value: item.patternNumber
            onClick: @colorsClick
            className: 'item-colors',
              'Colors'
        buttons.push button
          key: 'favs'
          className: 'item-favorite',
            '+'
        if extraButtons
          buttons.push button
            key: 'details'
            className: 'item-details',
              '='
        # Action buttons
        buttons = div
          className: 'item-icons hidden-xs',
            buttons
      else
        buttons = ''

      list.push li
        key: item.id,
          # Image
          img
            id: item.id
            width: item._file.small.width
            height: item._file.small.height
            src: item._file.small.path,
            onMouseOver: @setButtonsFor
          buttons


    return div
      className: 'pg-size-' + @props.initState.pgSize
      id: 'collection-' + @props.initState.category,
        ul
          className: 'list',
            list
