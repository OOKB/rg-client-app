React = require 'react'
{div, ul, li, a, img, i} = require 'reactionary'

CloseButton = require '../el/button_close'
ItemEl = require './item_el'

module.exports = React.createClass

  render: ->
    itemCount = @props.collection.length

    # Color icons.
    relatedColorItems = []
    @props.collection.forEach (item) ->
      relatedColorItems.push li
        key: item.id
        className: 'related-item',
          ItemEl
            imgSize: 'small'
            model: item
            itemState: {}

    relatedColorsList = ul
      className: 'list',
        relatedColorItems

    return div
      id: 'related-colors'
      className: 'trim',
        CloseButton
          onClick: => @props.setItemState colorBoxView: false
        relatedColorsList
