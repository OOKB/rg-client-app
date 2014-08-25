React = require 'react'
{h3, p, span, ul, li} = require 'reactionary'

module.exports = React.createClass

  render: ->
    item = @props.model

    h_lis = []

    # Name and number.
    name = if item.name then span item.name else false
    h_lis.push li
      key: 'name'
      className: 'name',
        h3 {}, item.label or item.category
        p {},
          name
          span {}, item.id

    # Color.
    h_lis.push li
      key: 'color'
      className: 'color',
        h3 'Color'
        p item.color

    # Content.
    if item.content
      h_lis.push li
        key: 'content'
        className: 'content',
          h3 'Content'
          p item.contents

    # Repeat.
    if item.repeat
      h_lis.push li
        key: 'repeat'
        className: 'repeat',
          h3 'Repeat'
          p item.repeat

    # Approx width.
    if item.approx_width
      h_lis.push li
        key: 'width'
        className: 'width',
          h3 'Approx Width'
          p item.approx_width

    # Approx size.
    if item.approx_size
      h_lis.push li
        key: 'size'
        className: 'size',
          h3 'Approx Size'
          p item.approx_size

    # Approx width.
    if item.approx_thick
      h_lis.push li
        key: 'thick'
        className: 'thick',
          h3 'Approx Thickness'
          p item.approx_thick

    ul
      className: 'item-information',
        h_lis
