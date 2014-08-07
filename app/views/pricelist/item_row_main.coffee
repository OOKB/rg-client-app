React = require 'react'
{tr, th, a} = require 'reactionary'

module.exports = React.createClass

  propTypes:
    item: React.PropTypes.object.isRequired
    filter: React.PropTypes.object.isRequired
    colorValue: React.PropTypes.any.isRequired

  render: ->
    td = th
    tds = []
    item = @props.item
    # Hide name for trims.
    unless @props.filter.category == 'passementerie'
      tds.push td
        key: 'name'
        className: 'c-name', item.name

    # Show for all.
    tds.push td
      key: 'number'
      className: 'c-number', @props.idValue

    tds.push td
      key: 'color'
      className: 'c-color', @props.colorValue

    tds.push td
      key: 'price'
      className: 'c-price', item.price

    tds.push td
      key: 'content'
      className: 'c-content', item.contents
    # Hide repeat for leather.
    unless @props.filter.category == 'leather'
      tds.push td
        key: 'repeat'
        className: 'c-repeat', item.repeat

    tds.push td
      key: 'size'
      className: 'c-size', item.approx_width

    tr className: 'pattern', tds
