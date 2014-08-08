React = require 'react'
{nav, div, button, h3, p, span, ul, li} = require 'reactionary'

module.exports = React.createClass

  handleXclick: ->
    window.history.back()

  render: ->
    item = @props.model

    h_lis = []

    # Name and number.
    h_lis.push li
      key: 'color'
      className: 'name',
        h3 {}, item.label or item.category
        p {},
          span {}, item.name
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

    nav className: 'item-detail-header',
      div className: 'controls',
        ul {},
          li className: 'fav',
            button className: 'fav', '+'
          li className: 'close',
            button
              className: 'close'
              type: 'button'
              onClick: @handleXclick
              'area-hidden': 'true',
                'X'
        h3 className: 'hidden-md hidden-lg', 'Details'
        button
          className: 'toggle hidden-md hidden-lg'
          type: 'button',
            'Reveal Menu'
      div className: 'item-detail-content',
        ul h_lis
