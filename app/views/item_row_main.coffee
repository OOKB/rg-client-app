React = require 'react'
{tr, th} = require 'reactionary'

module.exports = React.createClass
  render: ->
    td = th
    tds = []
    item = @props.item
    # Hide name for trims.
    unless @props.filter.category == 'passementerie'
      tds.push td(className: 'c-name', item.name)

    # Show for all.
    tds.push td(className: 'c-number', item.id)
    tds.push td(className: 'c-color', item.color)
    tds.push td(className: 'c-price', item.price) # Price
    tds.push td(className: 'c-content', item.contents) # Content
    # Hide repeat for leather.
    unless @props.filter.category == 'leather'
      tds.push td(className: 'c-repeat', item.repeat)
    tds.push td(className: 'c-size', item.approx_width) # Size

    tr className: 'pattern', tds
