React = require 'react'
{tr, td} = require 'reactionary'

module.exports = React.createClass
  render: ->
    tr className: 'pattern',
      td ''
      td @props.item.color_id
      td @props.item.color
      td ''
      td ''
