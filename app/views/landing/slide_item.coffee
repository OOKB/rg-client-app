React = require 'react'
{li, a, p, h3, div} = require 'reactionary'

module.exports = React.createClass
  render: ->
    link = @props.model.detail or '#collection'
    li
      className: 'item'+(@props.i+1)
      a # Hidden with CSS.
        href: link,
          @props.model.name
      div
        className: 'popover',
          h3
            className: 'name',
              @props.model.name
          p
            className: 'color',
              @props.model.color
