React = require 'react'
{tr, td} = require 'reactionary'

module.exports = React.createClass

  render: ->
    tds = []
    item = @props.item
    # Hide name for trims.
    unless @props.filter.category == 'passementerie'
      if @props.showName
        tds.push td
          key: 'name'
          className: 'c-name',
            item.name
      else
        tds.push td
          key: 'name'
          className: 'c-name'
    # Show for all.
    tds.push td
      key: 'number'
      className: 'c-number', @props.idValue
    tds.push td
      key: 'color'
      className: 'c-color', @props.colorValue
    tds.push td
      key: 'price'
      className: 'c-price'

    # Rowspan of hr item consumes this column.
    # tds.push td
    #   key: 'content'
    #   className: 'c-content'

    # Hide repeat for leather.
    unless @props.filter.category == 'leather'
      tds.push td
        key: 'repeat'
        className: 'c-repeat'
    tds.push td
      key: 'size'
      className: 'c-size'

    tr className: 'color', tds
