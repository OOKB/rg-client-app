React = require 'react'
{div, p, button, a} = require 'reactionary'
_ = require 'lodash'

# Confirm item added to favorites

module.exports = React.createClass
  close: ->
    @props.setItemState favBoxView: false

  text: ->
    item = @props.model
    item.name + ' in ' + item.color + ' has been added to your favorites!'

  render: () ->
    unless @props.itemState.favBoxView
      return false
    div
      className: 'alert-favorite',
        button
          type: 'button'
          onClick: @close
          className: 'close small',
            'x'
        div
          className: 'outer',
            div
              className: 'inner',
                p @text()
                p {}, a(href: '#favs', 'View and share')
