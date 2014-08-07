React = require 'react'
{tr, td} = require 'reactionary'

module.exports = React.createClass

  render: ->
    tds = []
    item = @props.item
    # Hide name for trims.
    unless @props.filter.category == 'passementerie'
      if @props.showName
        tds.push td(className: 'c-name', item.name)
      else
        tds.push td(className: 'c-name', '')
    # Show for all.
    tds.push td
      key: 'number'
      className: 'c-number', item.color_id
    tds.push td
      key: 'color'
      className: 'c-color', @props.colorValue
    tds.push td(className: 'c-price', '') # Price
    tds.push td(className: 'c-content', '') # Content
    # Hide repeat for leather.
    unless @props.filter.category == 'leather'
      tds.push td(className: 'c-repeat', '')
    tds.push td(className: 'c-size', '') # Size

    tr className: 'color', tds
