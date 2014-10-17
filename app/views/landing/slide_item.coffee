React = require 'react'
{li, a, p, h3, div} = require 'reactionary'

module.exports = React.createClass
  render: ->
    li
      className: 'item'+(@props.i+1)
      a # Hidden with CSS.
        href: "link-to-item1",
          @props.model.name
      div
        classzName: 'popover',
          h3
            className: 'name',
              @props.model.name
        p
          className: 'color',
            @props.model.color
