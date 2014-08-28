React = require 'react'
{h3, p, span, ul, li} = require 'reactionary'

module.exports = React.createClass

  round: (x, to) ->
    Math.round(x / to) * to

  render: ->
    item = @props.model

    h_lis = []
    fieldCount = 0
    charCount = 0
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
      fieldCount++
      charCount += item.contents.length
      h_lis.push li
        key: 'content'
        className: 'content',
          h3 'Content'
          p item.contents

    # Repeat.
    if item.repeat
      fieldCount++
      charCount += item.repeat.length
      h_lis.push li
        key: 'repeat'
        className: 'repeat',
          h3 'Repeat'
          p item.repeat


    # Approx width.
    if item.approx_width
      fieldCount++
      charCount += item.approx_width.length
      h_lis.push li
        key: 'width'
        className: 'width',
          h3 'Approx Width'
          p item.approx_width

    # Approx size.
    if item.approx_size
      fieldCount++
      charCount += item.approx_size.length
      h_lis.push li
        key: 'size'
        className: 'size',
          h3 'Approx Size'
          p item.approx_size

    # Approx thick.
    if item.approx_thick
      fieldCount++
      charCount += item.approx_thick.length
      h_lis.push li
        key: 'thick'
        className: 'thick',
          h3 'Approx Thickness'
          p item.approx_thick

    if item.price
      fieldCount++
      charCount += 3
      h_lis.push li
        key: 'price'
        className: 'price',
          h3 'Price'
          p item.priceDisplay

    fieldsClass = 'item-information'
    fieldsClass += ' f-qty-'+fieldCount
    fieldsClass += ' char-qty-'+@round(charCount, 25)
    ul
      className: fieldsClass,
        h_lis
