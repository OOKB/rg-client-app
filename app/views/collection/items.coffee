React = require 'react'
{div, p, ul, li, button, img, i} = require 'reactionary'

module.exports = React.createClass
  getInitialState: ->
    buttonsFor: @props.buttonsForInit
    colors: false

  setButtonsFor: (e) ->
    @setState buttonsFor: e.target.id

  colorsClick: (e) ->
    if 'passementerie' == @props.initState.category
      if @state.colors
        @setState colors: false
        @props.setRouterState
          searchTxt: ''
      else
        @setState colors: true
        @props.setRouterState
          searchTxt: e.target.value

  render: ->
    list = []

    # List
    @props.collection.forEach (item, index) =>
      if @state.buttonsFor == item.id
        # Action buttons
        buttons = div
          className: 'item-icons hidden-xs',
            button
              value: item.patternNumber
              onClick: @colorsClick
              className: 'item-colors',
                'Colors'
            button
              className: 'item-favorite',
                '+'
            button
              className: 'item-details',
                '='
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
