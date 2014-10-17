React = require 'react'
{li, a, p, h3, div} = require 'reactionary'

module.exports = React.createClass
  render: ->
    indexClass = 'item'+(@props.i+1)
    if @props.model
      model = @props.model
    else # MISSING ITEM!
      return li className: indexClass
    if model.hasDetail
      link = model.detail
    else
      link = '#collection'
    li
      className: indexClass
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
