React = require 'react'
{div, p, button, a} = require 'reactionary'

# Confirm item added to favorites
CloseButton = require './button_close'

module.exports = React.createClass
  close: ->
    @props.setItemState favBoxView: false

  text: ->
    item = @props.model
    name = item.name or item.patternNumber
    name + ' in ' + item.color + ' has been added to your favorites!'

  render: () ->
    unless @props.itemState.favBoxView
      return false
    div
      className: 'alert-favorite',
        CloseButton
          onClick: @close
        div
          className: 'outer',
            div
              className: 'inner',
                p @text()
                p {}, a(href: '#favs', 'View and share')
