React = require 'react'
{div, ul, li, button, img, i} = require 'reactionary'

module.exports = React.createClass
  getInitialState: ->
    buttonsFor: ''

  setButtonsFor: (e) ->
    @setState buttonsFor: e.target.id

  render: ->
    list = []
    @props.collection.forEach (item, index) =>
      if @state.buttonsFor == item.id
        buttons = div
          className: 'item-icons',
            button
              className: 'item-colors',
                'Colors'
            button
              className: 'item-favorite',
                '+'
            button
              className: 'item-details',
                i
                  className: 'fa fa-align-justify',
                    'i'
      else
        buttons = ''

      list.push li
        key: item.id,
          img
            id: item.id
            src: item._file.small.path,
            onMouseOver: @setButtonsFor
          buttons


    div
      className: 'threeup'
      id: 'products',
        ul
          className: 'list slider',
            list
