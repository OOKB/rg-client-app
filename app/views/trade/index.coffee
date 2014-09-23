React = require 'react'
{div, p, a, h3} = require 'reactionary'

module.exports = React.createClass

  render: ->
    console.log @props
    div
      className: 'trade-info content text'
      dangerouslySetInnerHTML:
        __html: @props.initState.content
