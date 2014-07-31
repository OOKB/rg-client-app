React = require 'react'
{tr, th} = require 'reactionary'

module.exports = React.createClass
  render: ->
    tr className: 'pattern',
      th @props.item.name
      th @props.item.patternNumber+'-'+@props.item.color_id
      th @props.item.color
      th @props.item.price
      th @props.item.size
