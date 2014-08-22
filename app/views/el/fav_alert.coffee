React = require 'react'
{div, p, button, a} = require 'reactionary'
_ = require 'lodash'

# Confirm item added to favorites

module.exports = React.createClass
  close: ->
    @props.setItemState favBoxView: false

  text: ->
    item = @props.model
    item.name + ' in ' + item.color + ' has been added to your favorites.'

  render: () ->
    unless @props.itemState.favBoxView
      return false
    div
      id: 'anonymous-faves-alert'
      className: 'alert-favorite alert alert-dismissable text-center',
        button
          type: 'button'
          onClick: @close
          className: 'close',
            'x'
        div
          className: 'outer',
            div
              className: 'inner',
                p @text()
                p {}, a(href: '#favs', 'View and share')
