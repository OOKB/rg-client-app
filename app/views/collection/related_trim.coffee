React = require 'react'
{div, button, ul, li, a, img, i} = require 'reactionary'

module.exports = React.createClass

  render: ->
    itemCount = @props.collection.length

    # Color icons.
    relatedColorItems = []
    @props.collection.forEach (item) ->
      relatedColorItems.push li
        key: item.id
        className: 'related-item',
          img
            id: item.color_id
            src: item._file.small.path
            alt: item.color

    relatedColorsList = ul
      className: 'list',
        relatedColorItems

    return div
      id: 'related-colors'
      className: 'trim',
        relatedColorsList
