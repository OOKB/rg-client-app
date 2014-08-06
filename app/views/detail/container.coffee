React = require 'react'
{div, table, tbody, tr, td, button, h3, p, span} = require 'reactionary'

HeaderBar = require './header'
Switcher = require './buttons'

module.exports = React.createClass

  render: ->
    item = @props.model
    #console.log item.toJSON()
    color_toggle_class = 'toggle-colors hidden-xs'
    if item.far
      color_toggle_class += ' with-far'
    div className: 'item-detail',
      HeaderBar model: item
      Switcher model: item
